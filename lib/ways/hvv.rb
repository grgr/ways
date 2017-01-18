require 'net/http'
require 'base64'
require 'cgi'
require 'openssl'

module Ways
  module Hvv

    class << self

      def prepare_results(res)
        parsed = JSON.parse(res.body)
        parsed[Ways.resp_leglist_key].inject([]) do |results, trip|
          result = {duration: trip[Ways.resp_trip_duration_key]}
          result.update leglist: extract_leg_info(trip) 
          results << result
          results
        end
      end

      def extract_leg_info(leglist)
        leglist[Ways.resp_leg_key].inject([]) do |new_leglist, leg|

          extracted = {info: {}, origin: {}, dest: {}}

          #extracted[:info].update index: leg[Ways.resp_leg_idx_key]
          extracted[:info].update type: unify_output(leg[Ways.resp_leg_line_key][Ways.resp_leg_type_key][Ways.resp_leg_simple_type_key])
          extracted[:info].update direction: leg[Ways.resp_leg_line_key][Ways.resp_leg_direction_key]
          #extracted[:info].update category: leg[Ways.resp_leg_category_key]
          #extracted[:info].update name: leg[Ways.resp_leg_name_key]
          #extracted[:info].update duration: leg[Ways.resp_leg_duration_key]
          #extracted[:info].update distance: leg[Ways.resp_leg_dist_key]

          extracted[:origin].update name: leg[Ways.resp_leg_origin_key][Ways.resp_leg_origin_name_key]
          extracted[:origin].update time: leg[Ways.resp_leg_origin_key][Ways.resp_leg_origin_datetime_key][Ways.resp_leg_origin_time_key]
          extracted[:origin].update date: leg[Ways.resp_leg_origin_key][Ways.resp_leg_origin_datetime_key][Ways.resp_leg_origin_date_key]

          extracted[:dest].update name: leg[Ways.resp_leg_dest_key][Ways.resp_leg_dest_name_key]
          extracted[:dest].update time: leg[Ways.resp_leg_dest_key][Ways.resp_leg_dest_datetime_key][Ways.resp_leg_dest_time_key]
          extracted[:dest].update date: leg[Ways.resp_leg_dest_key][Ways.resp_leg_dest_datetime_key][Ways.resp_leg_dest_date_key]

          new_leglist << extracted
          new_leglist
        end
      end

      def unify_output(key)
        unifier = {
          'FOOTPATH' => 'WALK',
          'TRAIN'    => 'TRAIN'
        }
        unifier[key] || key
      end

      def get_results(from, to, date_time, lang, opts)
        uri = URI(Ways.api_trip_url)
        req = Net::HTTP::Post.new(uri)
        req.body = parametrize(from, to, date_time, lang, opts).to_json

        hmac = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), Ways.api_password.encode("UTF-8"), req.body.to_s)
        signature = Base64.encode64(hmac).chomp

        req[Ways.api_username_key] = Ways.api_username
        req[Ways.api_password_key] = signature

        req['geofox-auth-type'] = 'HmacSHA1'
        req['Accept'] = 'application/json'
        req['Content-type'] = 'application/json'

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
            http.request(req)
        end
      end

      def parametrize(from, to, date_time, lang, opts)
        params = {
          "#{Ways.api_version_key}" =>      Ways.api_version,
          "#{Ways.api_lang_key}" =>         lang,
          "#{Ways.api_origin_key}" => {
            "#{Ways.place_type.downcase}" => {
              "#{Ways.api_origin_lat_key}" =>  from[Ways.app_lat_key],
              "#{Ways.api_origin_long_key}" => from[Ways.app_long_key],
            },
            "#{Ways.place_type_key}" => Ways.place_type 
          },
          "#{Ways.api_dest_key}" => {
            "#{Ways.place_type.downcase}" => {
              "#{Ways.api_dest_lat_key}" =>    to[Ways.app_lat_key],
              "#{Ways.api_dest_long_key}" =>   to[Ways.app_long_key],
            },
            "#{Ways.place_type_key}" => Ways.place_type 
          },
          "#{Ways.api_time_key}" => {
            "#{Ways.api_time_key}" =>          date_time.strftime('%H:%M'),
            "#{Ways.api_date_key}" =>          date_time.strftime('%d.%m.%Y'),
          }
        }
        
        params.update( "#{Ways.api_departure_bool_key}" => !opts[:arrival] ) unless opts[:arrival].nil?
        params.update( "#{Ways.api_results_before_count_key}" => opts[:trips_before] ) unless opts[:trips_before].nil?
        params.update( "#{Ways.api_results_after_count_key}" => [0, opts[:trips_after] - 1].max ) unless opts[:trips_after].nil?
        #params.update( "#{Ways.api_origin_walk_key}" => opts[:origin_walk] ) unless opts[:origin_walk].nil?

        params
      end

    end
  end
end

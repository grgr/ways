require 'net/http'

module Ways
  module Hvv

    class << self

      def prepare_results(res)
        parsed = JSON.parse(res.body)
        parsed[Ways.resp_trip_key].inject([]) do |results, trip|
          result = {duration: trip[Ways.resp_trip_duration_key]}
          result.update leglist: extract_leg_info(trip[Ways.resp_leglist_key]) 
          results << result
          results
        end
      end

      def extract_leg_info(leglist)
        leglist[Ways.resp_leg_key].inject([]) do |new_leglist, leg|

          extracted = {info: {}, origin: {}, dest: {}}

          extracted[:info].update index: leg[Ways.resp_leg_idx_key]
          extracted[:info].update type: leg[Ways.resp_leg_type_key]
          extracted[:info].update direction: leg[Ways.resp_leg_direction_key]
          extracted[:info].update category: leg[Ways.resp_leg_category_key]
          extracted[:info].update name: leg[Ways.resp_leg_name_key]
          extracted[:info].update duration: leg[Ways.resp_leg_duration_key]
          extracted[:info].update distance: leg[Ways.resp_leg_dist_key]

          extracted[:origin].update name: leg[Ways.resp_leg_origin_key][Ways.resp_leg_origin_name_key]
          extracted[:origin].update time: leg[Ways.resp_leg_origin_key][Ways.resp_leg_origin_time_key]
          extracted[:origin].update date: leg[Ways.resp_leg_origin_key][Ways.resp_leg_origin_date_key]

          extracted[:dest].update name: leg[Ways.resp_leg_dest_key][Ways.resp_leg_dest_name_key]
          extracted[:dest].update time: leg[Ways.resp_leg_dest_key][Ways.resp_leg_dest_time_key]
          extracted[:dest].update date: leg[Ways.resp_leg_dest_key][Ways.resp_leg_dest_date_key]

          new_leglist << extracted
          new_leglist
        end
      end

      def get_results(from, to, date_time, lang, opts)
        uri = URI(Ways.api_trip_url)
        uri.query = URI.encode_www_form(parametrize(from, to, date_time, lang, opts))
        res = Net::HTTP.get_response(uri)
        res
      end

      def parametrize(from, to, date_time, lang, opts)
        params = {
          "#{Ways.api_access_id_key}" =>    Ways.api_access_id,
          "#{Ways.api_lang_key}" =>         lang,
          "#{Ways.api_origin_lat_key}" =>   from[Ways.app_lat_key],
          "#{Ways.api_origin_long_key}" =>  from[Ways.app_long_key],
          "#{Ways.api_dest_lat_key}" =>     to[Ways.app_lat_key],
          "#{Ways.api_dest_long_key}" =>    to[Ways.app_long_key],
          "#{Ways.api_time_key}" =>         date_time.strftime('%H:%M'),
          "#{Ways.api_date_key}" =>         date_time.strftime('%Y-%m-%d'),
          "#{Ways.api_format_key}" =>       Ways.api_format
        }
        
        params.update( "#{Ways.api_arrival_bool_key}" => opts[:arrival] ) if opts[:arrival]
        params.update( "#{Ways.api_origin_walk_key}" => opts[:origin_walk] ) if opts[:origin_walk]

        params
      end

    end
  end
end

require 'net/http'
require 'base64'
require 'cgi'
require 'openssl'

module Ways
  module Hvv

    class << self

      def prepare_results(res)
        parsed = JSON.parse(res.body)
        parsed['schedules'].inject([]) do |results, trip|
          result = {duration: trip['time']}
          result.update leglist: extract_leg_info(trip) 
          results << result
          results
        end
      end

      def extract_leg_info(leglist)
        leglist['scheduleElements'].inject([]) do |new_leglist, leg|

          extracted = {info: {}, origin: {}, dest: {}}

          extracted[:info].update type: unify_output(leg['line']['type']['simpleType'])
          extracted[:info].update direction: leg['line']['direction']

          extracted[:origin].update name: leg['from']['name']
          extracted[:origin].update type: unify_output(leg['from']['type'])
          extracted[:origin].update serviceTypes: extract_service_types(leg['from']['serviceTypes'])
          extracted[:origin].update time: leg['from']['depTime']['time']
          extracted[:origin].update date: leg['from']['depTime']['date']

          extracted[:dest].update name: leg['to']['name']
          extracted[:dest].update type: unify_output(leg['to']['type'])
          extracted[:dest].update serviceTypes: extract_service_types(leg['to']['serviceTypes'])
          extracted[:dest].update time: leg['to']['arrTime']['time']
          extracted[:dest].update date: leg['to']['arrTime']['date']

          new_leglist << extracted if extracted[:info][:type] != 'CHANGE'
          new_leglist
        end
      end

      def unify_output(key)
        unifier = {
          'FOOTPATH'   => 'WALK',
          'TRAIN'      => 'TRAIN',
          'STATION'    => 'STATION',
          'COORDINATE' => 'ADDRESS'
        }
        unifier[key] || key
      end

      def extract_service_types(key)
        key && key.first && key.first.upcase
      end

      def get_results(from, to, date_time, lang, opts)
        uri = URI(Ways.api_trip_url)
        req = Net::HTTP::Post.new(uri)
        req.body = parametrize(from, to, date_time, lang, opts).to_json

        hmac = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), Ways.api_password.encode("UTF-8"), req.body.to_s)
        signature = Base64.encode64(hmac).chomp

        req['geofox-auth-user'] = Ways.api_username
        req['geofox-auth-signature'] = signature

        req['geofox-auth-type'] = 'HmacSHA1'
        req['Accept'] = 'application/json'
        req['Content-type'] = 'application/json'

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
            http.request(req)
        end
      end

      def parametrize(from, to, date_time, lang, opts)
        params = {
          "version" =>      Ways.api_version,
          "language" =>         lang,
          "start" => {
            "coordinate" => {
              "y" => from[:lat],
              "x" => from[:long],
            },
            "type" => 'COORDINATE' 
          },
          "dest" => {
            "coordinate" => {
              "y" =>   to[:lat],
              "x" =>   to[:long],
            },
            "type" => 'COORDINATE' 
          },
          "time" => {
            "time" =>          date_time.strftime('%H:%M'),
            "date" =>          date_time.strftime('%d.%m.%Y'),
          }
        }
        
        params.update( "timeIsDeparture" => !opts[:arrival] ) unless opts[:arrival].nil?
        params.update( "schedulesBefore" => opts[:trips_before] ) unless opts[:trips_before].nil?
        params.update( "schedulesAfter" => [0, opts[:trips_after] - 1].max ) unless opts[:trips_after].nil?

        params
      end

    end
  end
end

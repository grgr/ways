require 'net/http'

module Ways
  module Vbb

    class << self

      def prepare_results(res)
        parsed = JSON.parse(res.body)
        #binding.pry
        parsed['Trip'].inject([]) do |results, trip|
          result = {duration: extract_duration(trip['duration'])}
          result.update leglist: extract_leg_info(trip['LegList']) 
          results << result
          results
        end
      end

      def extract_leg_info(leglist)
        leglist['Leg'].inject([]) do |new_leglist, leg|

          extracted = {info: {}, origin: {}, dest: {}}

          extracted[:info].update type: unify_output(leg['type'])
          extracted[:info].update direction: leg['direction']

          extracted[:origin].update name: leg['Origin']['name']
          extracted[:origin].update type: unify_output(leg['Origin']['type'])
          extracted[:origin].update serviceTypes: extract_service_types(extracted[:origin][:type], leg['category'])
          extracted[:origin].update time: leg['Origin']['time']
          extracted[:origin].update date: leg['Origin']['date']

          extracted[:dest].update name: leg['Destination']['name']
          extracted[:dest].update type: unify_output(leg['Destination']['type'])
          extracted[:dest].update serviceTypes: extract_service_types(extracted[:dest][:type], leg['category'])
          extracted[:dest].update time: leg['Destination']['time']
          extracted[:dest].update date: leg['Destination']['date']

          new_leglist << extracted
          new_leglist
        end
      end

      def unify_output(key)
        unifier = {
          'WALK' => 'WALK',
          'JNY'  => 'TRAIN',
          'ST'   => 'STATION',
          'ADR'  => 'ADDRESS'
        }
        unifier[key] || key
      end

      def extract_duration(string)
        return nil unless string

        minutes = string.match(/\d+M/)
        minutes = minutes && minutes[0].sub('M', '')

        hours   = string.match(/\d+H/)
        hours   = hours && hours[0].sub('M', '')

        hours.to_i * 60 + minutes.to_i
      end

      def extract_service_types(type, category)
        type == 'STATION' ? category : nil
      end

      def get_results(from, to, date_time, lang, opts)
        uri = URI(Ways.api_trip_url)
        uri.query = URI.encode_www_form(parametrize(from, to, date_time, lang, opts))
        Net::HTTP.get_response(uri)
      end

      def parametrize(from, to, date_time, lang, opts)
        params = {
          "accessId" =>    Ways.api_access_id,
          "lang" =>         lang,
          "originCoordLat" =>   from[:lat],
          "originCoordLong" =>  from[:long],
          "destCoordLat" =>     to[:lat],
          "destCoordLong" =>    to[:long],
          "time" =>         date_time.strftime('%H:%M'),
          "date" =>         date_time.strftime('%Y-%m-%d'),
          "format" =>       "json"
        }
        
        params.update( "searchForArrival" => opts[:arrival] ) unless opts[:arrival].nil?
        params.update( "numB" => opts[:trips_before] ) unless opts[:trips_before].nil?
        params.update( "numF" => opts[:trips_after] ) unless opts[:trips_after].nil?
        params.update( "originWalk" => opts[:origin_walk] ) unless opts[:origin_walk].nil?

        params
      end

    end
  end
end

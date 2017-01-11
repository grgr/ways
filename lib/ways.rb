require 'net/http'

module Ways

  class << self

    # query 
    mattr_accessor :api
    mattr_accessor :api_base_url
    mattr_accessor :api_trip_url
    mattr_accessor :api_access_id
    mattr_accessor :api_access_id_key 
    mattr_accessor :api_lang_key 
    mattr_accessor :api_origin_lat_key
    mattr_accessor :api_origin_long_key
    mattr_accessor :api_dest_lat_key
    mattr_accessor :api_dest_long_key
    mattr_accessor :api_time_key
    mattr_accessor :api_date_key
    mattr_accessor :api_arrival_bool_key
    mattr_accessor :api_origin_walk_key
    mattr_accessor :api_format_key
    mattr_accessor :api_format

    # response 
    mattr_accessor :resp_trip_key
    mattr_accessor :resp_trip_duration_key
    mattr_accessor :resp_leglist_key
    mattr_accessor :resp_leg_key

    # response leg general info
    mattr_accessor :resp_leg_idx_key
    mattr_accessor :resp_leg_type_key
    mattr_accessor :resp_leg_direction_key
    mattr_accessor :resp_leg_category_key
    mattr_accessor :resp_leg_name_key
    mattr_accessor :resp_leg_duration_key
    mattr_accessor :resp_leg_dist_key

    # response leg origin
    mattr_accessor :resp_leg_origin_key
    mattr_accessor :resp_leg_origin_name_key
    mattr_accessor :resp_leg_origin_time_key
    mattr_accessor :resp_leg_origin_date_key

    # response leg destination
    mattr_accessor :resp_leg_dest_key
    mattr_accessor :resp_leg_dest_name_key
    mattr_accessor :resp_leg_dest_time_key
    mattr_accessor :resp_leg_dest_date_key

    # app
    mattr_accessor :app_lat_key
    mattr_accessor :app_long_key

    def setup
      yield self
    end 

    def from_to(from, to, date_time=nil, lang='de', opts={})
      date_time ||= DateTime.now

      prepare_results(get_results(from, to, date_time, lang, opts))
    end

    def prepare_results(res)
      parsed = JSON.parse(res.body)
      parsed[resp_trip_key].inject([]) do |results, trip|
        result = {duration: trip[resp_trip_duration_key]}
        result.update leglist: extract_leg_info(trip[resp_leglist_key]) 
        results << result
        results
      end
    end

    def extract_leg_info(leglist)
      leglist[resp_leg_key].inject([]) do |new_leglist, leg|

        extracted = {info: {}, origin: {}, dest: {}}

        extracted[:info].update index: leg[resp_leg_idx_key]
        extracted[:info].update type: leg[resp_leg_type_key]
        extracted[:info].update direction: leg[resp_leg_direction_key]
        extracted[:info].update category: leg[resp_leg_category_key]
        extracted[:info].update name: leg[resp_leg_name_key]
        extracted[:info].update duration: leg[resp_leg_duration_key]
        extracted[:info].update distance: leg[resp_leg_dist_key]

        extracted[:origin].update name: leg[resp_leg_origin_key][resp_leg_origin_name_key]
        extracted[:origin].update time: leg[resp_leg_origin_key][resp_leg_origin_time_key]
        extracted[:origin].update date: leg[resp_leg_origin_key][resp_leg_origin_date_key]

        extracted[:dest].update name: leg[resp_leg_dest_key][resp_leg_dest_name_key]
        extracted[:dest].update time: leg[resp_leg_dest_key][resp_leg_dest_time_key]
        extracted[:dest].update date: leg[resp_leg_dest_key][resp_leg_dest_date_key]

        new_leglist << extracted
        new_leglist
      end
    end

    def get_results(from, to, date_time, lang, opts)
      uri = URI(api_trip_url)
      uri.query = URI.encode_www_form(parametrize(from, to, date_time, lang, opts))
      res = Net::HTTP.get_response(uri)
      res
    end

    def parametrize(from, to, date_time, lang, opts)
      params = {
        "#{api_access_id_key}" =>    api_access_id,
        "#{api_lang_key}" =>         lang,
        "#{api_origin_lat_key}" =>   from[app_lat_key],
        "#{api_origin_long_key}" =>  from[app_long_key],
        "#{api_dest_lat_key}" =>     to[app_lat_key],
        "#{api_dest_long_key}" =>    to[app_long_key],
        "#{api_time_key}" =>         date_time.strftime('%H:%M'),
        "#{api_date_key}" =>         date_time.strftime('%Y-%m-%d'),
        "#{api_format_key}" =>       api_format
      }
      
      params.update( "#{api_arrival_bool_key}" => opts[:arrival] ) if opts[:arrival]
      params.update( "#{api_origin_walk_key}" => opts[:origin_walk] ) if opts[:origin_walk]

      params
    end
  end

end

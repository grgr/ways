module Ways

  autoload :Vbb, "ways/vbb"
  autoload :Hvv, "ways/hvv"

  class << self

    # query 
    mattr_accessor :api
    mattr_accessor :api_base_url
    mattr_accessor :api_trip_url
    mattr_accessor :api_access_id
    mattr_accessor :api_access_id_key 
    mattr_accessor :api_username_key
    mattr_accessor :api_username
    mattr_accessor :api_password_key
    mattr_accessor :api_password
    mattr_accessor :api_version_key
    mattr_accessor :api_version
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

      results = "Ways::#{Ways.api.to_s.classify}".constantize.get_results(from, to, date_time, lang, opts)
      "Ways::#{Ways.api.to_s.classify}".constantize.prepare_results(results)
    end

  end

end

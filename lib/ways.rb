require 'net/http'

module Ways

  class << self

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

    mattr_accessor :app_lat_key
    mattr_accessor :app_long_key

    def setup
      yield self
    end 

    def from_to(from, to, date_time=nil, lang='de', opts={})
      date_time ||= DateTime.now

      get_results(from, to, date_time, lang, opts)
    end

    def prepare_results(from, to, date_time, lang, opts)
    end

    def get_results(from, to, date_time, lang, opts)
      uri = URI(api_trip_url)
      uri.query = URI.encode_www_form(parametrize(from, to, date_time, lang, opts))
      res = Net::HTTP.get_response(uri)
      binding.pry
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

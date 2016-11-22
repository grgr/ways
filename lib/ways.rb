require 'net/http'

module Ways

  class << self

    mattr_accessor :api
    mattr_accessor :api_url
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

    mattr_accessor :app_lat_key
    mattr_accessor :app_long_key

    def setup
      yield self
    end 

    def from_to(from, to, time=nil, date=nil, lang='de', opts={})
      time ||= Time.now
      date ||= Date.today

      get_results(from, to, time, date, lang, opts)
    end

    def prepare_results(from, to, time, date, lang, opts)
    end

    def get_results(from, to, time, date, lang, opts)
      uri = URI(api_url)
      uri.query = URI.encode_www_form([parametrize(from, to, time, date, lang, opts)])
      Net::HTTP.get_response(uri)
    end

    def parametrize(from, to, time, date, lang, opts)
      params = {
        "#{api_access_id_key}" =>    api_access_id,
        "#{api_lang_key}" =>         lang,
        "#{api_origin_lat_key}" =>   from[app_lat_key],
        "#{api_origin_long_key}" =>  from[app_long_key],
        "#{api_dest_lat_key}" =>     to[app_lat_key],
        "#{api_dest_long_key}" =>    to[app_long_key],
        "#{api_time_key}" =>         time,
        "#{api_date_key}" =>         date
      }
      
      params.update( "#{api_arrival_bool_key}" => opts[:arrival] ) if opts[:arrival]
      params.update( "#{api_origin_walk_key}" => opts[:origin_walk] ) if opts[:origin_walk]

      params
    end
  end

end

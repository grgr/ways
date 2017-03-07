module Ways

  autoload :Vbb, "ways/vbb"
  autoload :Hvv, "ways/hvv"

  class << self

    # query 
    mattr_accessor :api
    mattr_accessor :api_trip_url
    mattr_accessor :api_access_id
    mattr_accessor :api_username
    mattr_accessor :api_password
    mattr_accessor :api_version

    def setup
      yield self
    end 

    def from_to(from, to, opts={})
      date_time = opts[:date_time] || DateTime.now
      lang = opts[:lang] || 'de'

      opts.update arrival: false if opts[:arrival].nil?
      opts.update trips_after: 1 if opts[:trips_after].nil?
      opts.update trips_before: 0 if opts[:trips_before].nil?

      results = "Ways::#{Ways.api.to_s.classify}".constantize.get_results(from, to, date_time, lang, opts)
      "Ways::#{Ways.api.to_s.classify}".constantize.prepare_results(results)
    end

  end

end

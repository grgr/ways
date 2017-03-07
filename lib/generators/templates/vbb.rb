Ways.setup do |config|

  # query 
  config.api = :vbb
  config.api_trip_url = "http://demo.hafas.de/openapi/vbb-proxy/trip"
  config.api_access_id = ENV['VBB_ACCESS_ID']

end

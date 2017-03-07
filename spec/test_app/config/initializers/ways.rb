Ways.setup do |config|

  # query 
  config.api = :hvv
  config.api_trip_url = "https://api-test.geofox.de/gti/public/getRoute"
  config.api_username = ENV['HVV_USERNAME']
  config.api_password = ENV['HVV_PASSWORD']
  config.api_version = '30'

end

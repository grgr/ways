Ways.setup do |config|

  config.api = :vbb
  config.api_base_url = "http://demo.hafas.de/openapi/vbb-proxy/"
  config.api_trip_url = "http://demo.hafas.de/openapi/vbb-proxy/trip"
  config.api_access_id = ENV['VBB_ACCESS_ID']
  config.api_access_id_key = 'accessId'
  config.api_lang_key = 'lang'
  config.api_origin_lat_key = 'originCoordLat'
  config.api_origin_long_key = 'originCoordLong'
  config.api_dest_lat_key = 'destCoordLat'
  config.api_dest_long_key = 'destCoordLong'
  config.api_time_key = 'time'
  config.api_date_key = 'date'
  config.api_arrival_bool_key = 'searchForArrival'
  config.api_origin_walk_key = 'originWalk'
  config.api_format_key = 'format'
  config.api_format = 'json'

  config.app_lat_key = :lat
  config.app_long_key = :long

end

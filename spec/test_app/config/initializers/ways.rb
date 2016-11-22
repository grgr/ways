Ways.setup do |config|

  config.api = :vbb
  config.api_url = "http://demo.hafas.de/openapi/vbb-proxy"
  config.api_access_id = ENV['VBB_ACCESS_ID']
  config.api_access_id_key = 'accessID'
  config.api_lang_key = 'lang'
  config.api_origin_lat_key = 'originCoordLat'
  config.api_origin_long_key = 'originCoordLong'
  config.api_dest_lat_key = 'destCoordLat'
  config.api_dest_long_key = 'destCoordLong'
  config.api_time_key = 'time'
  config.api_date_key = 'date'
  config.api_arrival_bool_key = 'searchForArrival'
  config.api_origin_walk_key = 'originWalk'

end

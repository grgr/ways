Ways.setup do |config|

  # query 
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

  # response 
  config.resp_trip_key = 'Trip'
  config.resp_trip_duration_key = 'duration'
  config.resp_leglist_key = 'LegList'
  config.resp_leg_key = 'Leg'

  # response leg general info
  config.resp_leg_idx_key = 'idx'
  config.resp_leg_type_key = 'type'
  config.resp_leg_direction_key = 'direction'
  config.resp_leg_category_key = 'category'
  config.resp_leg_name_key = 'name'
  config.resp_leg_duration_key = 'duration'
  config.resp_leg_dist_key = 'dist'

  # response leg origin
  config.resp_leg_origin_key = 'Origin'
  config.resp_leg_origin_name_key = 'name'
  config.resp_leg_origin_time_key = 'time'
  config.resp_leg_origin_date_key = 'date'

  # response leg destination
  config.resp_leg_dest_key = 'Destination'
  config.resp_leg_dest_name_key = 'name'
  config.resp_leg_dest_time_key = 'time'
  config.resp_leg_dest_date_key = 'date'

  # app
  config.app_lat_key = :lat
  config.app_long_key = :long

end

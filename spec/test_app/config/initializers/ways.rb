Ways.setup do |config|

  # query 
  config.api = :hvv
  config.api_trip_url = "https://api-test.geofox.de/gti/public/getRoute"
  config.api_username_key = 'geofox-auth-user'
  config.api_username = ENV['HVV_USERNAME']
  config.api_password_key = 'geofox-auth-signature'
  config.api_password = ENV['HVV_PASSWORD']
  config.api_version_key = 'version'
  config.api_version = '30'
  config.api_lang_key = 'language'
  config.api_origin_key = 'start'
  config.api_origin_lat_key = 'x'
  config.api_origin_long_key = 'y'
  config.api_dest_key = 'dest'
  config.api_dest_lat_key = 'x'
  config.api_dest_long_key = 'y'
  config.api_time_key = 'time'
  config.api_date_key = 'date'
  config.place_type_key = 'type'
  config.place_type = 'COORDINATE'
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

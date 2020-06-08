class FoodieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :end_location, :travel_time, :restaurant, :forecast

  set_id { |id| id = 'null' }
end

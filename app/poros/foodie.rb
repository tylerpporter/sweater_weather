class Foodie
  attr_reader :end_location, :travel_time, :restaurant, :forecast
  def initialize(location, restaurant, forecast)
    @end_location = location.end_location
    @travel_time = location.travel_time
    @restaurant = restaurant
    @forecast = forecast
  end
end

class Foodie
  attr_reader :end_location, :travel_time, :restaurant, :forecast
  def initialize(origin, destination, type)
    @origin = origin
    @destination = destination
    @type = type
    @end_location = location.end_location
    @travel_time = location.travel_time
    @restaurant = restaurant_info
    @forecast = forecast_info
  end

  private

  def location
    Trip.new(DirectionService.new(@origin, @destination).directions)
  end

  def forecast_info
    {
      summary: full_forecast.current.weather.description,
      temperature: full_forecast.current.temp
    }
  end

  def restaurant_info
    Restaurant.new(RestaurantService.new(@type, location).restaurant)
  end

  def create_city
    City.create(city_params)
  end

  def full_forecast
    @forecast ||= Forecast.new(forecast_request(create_city))
  end

  def destination_city
    @destination.split(',').first
  end

  def destination_state
    @destination.split(',').last
  end

  def forecast_request(city)
    OpenWeatherService.new(city.lat, city.lon, city.address).forecast
  end

  def city_params
    location = GeocodingService.new(destination_city, destination_state).lat_lon
    {
      name: destination_city,
      state: destination_state,
      lat: location[:location][:lat],
      lon: location[:location][:lng],
      address: location[:address]
    }
  end
end

class Api::V1::FoodieController < ApplicationController
  def show
    foodie = Foodie.new(location, restaurant, forecast)
    render json: FoodieSerializer.new(foodie)
  end

  private

  def location
    Trip.new(DirectionService.new(origin, destination).directions)
  end

  def restaurant
    Restaurant.new(RestaurantService.new(type, location).restaurant)
  end

  def forecast
    {
      summary: full_forecast.current.weather.description,
      temperature: full_forecast.current.temp
    }
  end

  def full_forecast
    @forecast ||= Forecast.new(forecast_request(create_city))
  end

  def create_city
    City.create(city_params)
  end

  def origin
    params[:start]
  end

  def destination
    params[:end]
  end

  def destination_city
    destination.split(',').first
  end

  def destination_state
    destination.split(',').last
  end

  def type
    params[:search]
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

class Api::V1::FoodieController < ApplicationController
  def show
    location = DirectionService.new(origin, destination).directions
    restaurant = RestaurantService.new(type, location).restaurant(type)
    destination_city = City.create(city_params)
    forecast = Forecast.new(forecast_request(destination_city))
    temp = forecast.current.temp
    summary = forecast.current.weather.description 
    require "pry"; binding.pry
  end

  private

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

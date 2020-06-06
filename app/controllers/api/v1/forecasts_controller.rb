class Api::V1::ForecastsController < ApplicationController
  def show
    city = find_or_create
    forecast = Forecast.new(forecast_request(city))
    render json: ForecastSerializer.new(forecast)
  end

  private

  def city_name
    params[:location].split(',').first
  end

  def state
    params[:location].split(',').last
  end

  def find_or_create
    city = City.find_by(name: city_name)
    city.nil? ? city = City.create(city_params) : city
  end

  def forecast_request(city)
    OpenWeatherService.new(city.lat, city.lon, city.address).forecast
  end

  def city_params
    location = GeocodingService.new(city_name, state).lat_lon
    {
      name: city_name,
      state: state,
      lat: location[:location][:lat],
      lon: location[:location][:lng],
      address: location[:address]
    }
  end
end

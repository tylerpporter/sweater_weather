class Api::V1::ForecastsController < ApplicationController
  def show
    City.create(city_params)
    render json: City.last
    # get the weather
    # render JSON
  end

  private

  def city
    params[:location].split(',').first
  end

  def state
    params[:location].split(',').last
  end

  def city_params
    location = GeocodingService.new(city, state).lat_lon
    {
      name: city,
      state: state,
      lat: location[:lat],
      lon: location[:lng]
    }
  end
end

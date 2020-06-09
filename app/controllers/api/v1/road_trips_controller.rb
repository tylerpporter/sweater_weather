class Api::V1::RoadTripsController < ApplicationController
  def create
    valid_key? ? create_trip : failure
  end

  private

  def create_trip
    @road_trip = RoadTrip.new(origin, destination)
    success
  end

  def success
    render '/road_trips/success.json'
  end

  def failure
    render '/road_trips/failure.json'
  end

  def valid_key?
    User.find_by(api_key: api_key)
  end

  def origin
    params[:origin]
  end

  def destination
    params[:destination]
  end

  def api_key
    params[:api_key]
  end
end

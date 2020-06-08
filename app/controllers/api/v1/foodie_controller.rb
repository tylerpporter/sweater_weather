class Api::V1::FoodieController < ApplicationController
  def show
    location_time = DirectionService.new(origin, destination).directions
    require "pry"; binding.pry
  end

  private

  def origin
    params[:start]
  end

  def destination
    params[:end]
  end
end

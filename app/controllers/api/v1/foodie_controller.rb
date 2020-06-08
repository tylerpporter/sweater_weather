class Api::V1::FoodieController < ApplicationController
  def show
    location = DirectionService.new(origin, destination).directions
    restaurant = RestaurantService.new(type, location).restaurant(type)
    require "pry"; binding.pry
  end

  private

  def origin
    params[:start]
  end

  def destination
    params[:end]
  end

  def type
    params[:search]
  end
end

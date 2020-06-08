class Api::V1::FoodieController < ApplicationController
  def show
    foodie = Foodie.new(origin, destination, type)
    render json: FoodieSerializer.new(foodie)
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

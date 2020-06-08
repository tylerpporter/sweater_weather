class Api::V1::FoodieController < ApplicationController
  def show
    DirectionService.new(origin, destination).directions
  end

  private

  def origin
    params[:start]
  end

  def destination
    params[:end]
  end
end

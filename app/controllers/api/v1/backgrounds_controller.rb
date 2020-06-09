class Api::V1::BackgroundsController < ApplicationController
  def show
    @image = ImageService.new(city_name).image
    update_city(@image)
    render '/backgrounds/show.json'
  end

  private

  def city_name
    params[:location].split(',').first
  end

  def update_city(image)
    city = City.find_by(name: city_name)
    city.update(image: image) unless city.nil?
  end
end

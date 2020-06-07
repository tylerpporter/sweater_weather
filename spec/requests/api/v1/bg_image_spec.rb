require 'rails_helper'

describe 'Background image request' do
  it 'retrieves an image url for a given city' do
    create_list(:city, 3)
    city = create(:city, name: 'denver')
    stub_image_service

    get '/api/v1/backgrounds?location=denver,co'
    resp = JSON.parse(response.body, symbolize_names: true)
    city.reload

    expect(resp[:data][:attributes][:image_url]).to eq(city.image)
  end
end

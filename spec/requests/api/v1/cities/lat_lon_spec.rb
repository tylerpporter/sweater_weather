require 'rails_helper'

describe 'Geocoding Service' do
  before :each do
    @lat_lon = parse_fixture('spec/fixtures/geocode.json')
    @lat = @lat_lon[:results].first[:geometry][:location][:lat].to_s
    @lng = @lat_lon[:results].first[:geometry][:location][:lng].to_s
    @forecast = parse_fixture('spec/fixtures/open_weather.json')
    stub_geocoding_service
    stub_open_weather_service(@lat,@lng)
  end
  it 'retrieves the latitude and longitude of a given city' do
    get "/api/v1/forecast?location=denver,co"

    city = City.last

    expect(city.name).to eq('denver')
    expect(city.state).to eq('co')
    expect(city.lat).to eq(@lat)
    expect(city.lon).to eq(@lng)
  end
  it 'retrieves the weather for a given city' do
    get "/api/v1/forecast?location=denver,co"

    city = City.last
    resp = JSON.parse(response.body, symbolize_names: true)
    
    expect(resp[:data][:attributes][:address]).to eq(city.address)
    expect(resp[:data][:attributes][:current]).to eq(@forecast[:current])
    expect(resp[:data][:attributes][:hourly]).to eq(@forecast[:hourly])
    expect(resp[:data][:attributes][:daily]).to eq(@forecast[:daily])
  end
end

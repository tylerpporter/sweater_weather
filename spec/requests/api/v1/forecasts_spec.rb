require 'rails_helper'

describe 'Forecast request' do
  before :each do
    @lat_lon = parse_fixture('spec/fixtures/geocode.json')
    @lat = @lat_lon[:results].first[:geometry][:location][:lat].to_s
    @lng = @lat_lon[:results].first[:geometry][:location][:lng].to_s
    @forecast = parse_fixture('spec/fixtures/open_weather.json')
    stub_geocoding_service
    stub_open_weather_service(@lat,@lng)
    get "/api/v1/forecast?location=denver,co"
    @resp = JSON.parse(response.body, symbolize_names: true)
  end
  it 'retrieves the latitude and longitude of a given city' do
    city = City.last

    expect(city.name).to eq('denver')
    expect(city.state).to eq('co')
    expect(city.lat).to eq(@lat)
    expect(city.lon).to eq(@lng)
  end
  it 'retrieves the weather for a given city' do
    city = City.last

    expect(@resp[:data][:attributes][:address]).to eq(city.address)
    expect(@resp[:data][:attributes][:current][:raw]).to eq(@forecast[:current])
    expect(@resp[:data][:attributes][:hourly].first[:raw]).to eq(@forecast[:hourly][4])
    expect(@resp[:data][:attributes][:daily].first[:raw]).to eq(@forecast[:daily].first)
  end
  it 'formats the current forecast for a given city' do

    expect(@resp[:data][:attributes][:current][:dt]).to eq("10:11 AM, June 06")
    expect(@resp[:data][:attributes][:current][:high]).to eq(89)
    expect(@resp[:data][:attributes][:current][:low]).to eq(74)
    expect(@resp[:data][:attributes][:current][:sunrise]).to eq("05:06 AM")
    expect(@resp[:data][:attributes][:current][:sunset]).to eq("07:23 PM")
    expect(@resp[:data][:attributes][:current][:temp]).to eq(81)
    expect(@resp[:data][:attributes][:current][:feels_like]).to eq(88)
    expect(@resp[:data][:attributes][:current][:humidity]).to eq(78)
    expect(@resp[:data][:attributes][:current][:visibility]).to eq("9 miles")
    expect(@resp[:data][:attributes][:current][:uv_index]).to eq("11 (extreme)")
    expect(@resp[:data][:attributes][:current][:weather][:main]).to eq("Clouds")
    expect(@resp[:data][:attributes][:current][:weather][:description]).to eq("broken clouds")
    expect(@resp[:data][:attributes][:current][:weather][:icon]).to eq("http://openweathermap.org/img/wn/04d@2x.png")
  end
  it 'formats the hourly forecast for a given city' do

    expect(@resp[:data][:attributes][:hourly].size).to eq(8)
    expect(@resp[:data][:attributes][:hourly].first[:dt]).to eq("02:00 PM")
    expect(@resp[:data][:attributes][:hourly].first[:temp]).to eq(92)
    expect(@resp[:data][:attributes][:hourly].first[:icon]).to eq("http://openweathermap.org/img/wn/01d@2x.png")
  end
  it 'formats the daily forecast for a given city' do

    expect(@resp[:data][:attributes][:daily].first[:dt]).to eq("Saturday")
    expect(@resp[:data][:attributes][:daily].first[:low]).to eq(74)
    expect(@resp[:data][:attributes][:daily].first[:high]).to eq(89)
    expect(@resp[:data][:attributes][:daily].first[:icon]).to eq("http://openweathermap.org/img/wn/10d@2x.png")
    expect(@resp[:data][:attributes][:daily].first[:description]).to eq("Rain")
    expect(@resp[:data][:attributes][:daily].first[:precip]).to eq("1 mm")
  end
end

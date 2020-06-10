require 'rails_helper'

describe 'Forecast request' do
  before :each do
    @lat_lon = parse_fixture('spec/fixtures/geocode.json')
    @lat = @lat_lon[:results].first[:geometry][:location][:lat].to_s
    @lng = @lat_lon[:results].first[:geometry][:location][:lng].to_s
    stub_geocoding_service
    stub_open_weather_service(@lat,@lng)
    get "/api/v1/forecast?location=denver,co"
  end
  it 'retrieves the latitude and longitude of a given city' do
    city = City.last

    expect(city.name).to eq('denver')
    expect(city.state).to eq('co')
    expect(city.lat).to eq(@lat)
    expect(city.lon).to eq(@lng)
  end
  it 'formats the current forecast for a given city' do

    expect(current[:dt]).to eq("10:11 AM, June 06")
    expect(current[:high]).to eq(89)
    expect(current[:low]).to eq(74)
    expect(current[:sunrise]).to eq("05:06 AM")
    expect(current[:sunset]).to eq("07:23 PM")
    expect(current[:temp]).to eq(81)
    expect(current[:feels_like]).to eq(88)
    expect(current[:humidity]).to eq(78)
    expect(current[:visibility]).to eq("9 miles")
    expect(current[:uv_index]).to eq("11 (extreme)")
    expect(current[:weather][:main]).to eq("Clouds")
    expect(current[:weather][:description]).to eq("broken clouds")
    expect(current[:weather][:icon]).to eq("http://openweathermap.org/img/wn/04d@2x.png")
  end
  it 'formats the hourly forecast for a given city' do

    expect(hourly.size).to eq(8)
    expect(hourly.first[:dt]).to eq("02:00 PM")
    expect(hourly.first[:temp]).to eq(92)
    expect(hourly.first[:icon]).to eq("http://openweathermap.org/img/wn/01d@2x.png")
  end
  it 'formats the daily forecast for a given city' do

    expect(daily.first[:dt]).to eq("Saturday")
    expect(daily.first[:low]).to eq(74)
    expect(daily.first[:high]).to eq(89)
    expect(daily.first[:icon]).to eq("http://openweathermap.org/img/wn/10d@2x.png")
    expect(daily.first[:description]).to eq("Rain")
    expect(daily.first[:precip]).to eq("1 mm")
  end
end

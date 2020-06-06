require 'rails_helper'

describe 'Geocoding Service' do
  it 'retrieves the latitude and longitude of a given city', :vcr do
    get "/api/v1/forecast?location=denver,co"

    city = City.last
    cassette = geo_response('spec/fixtures/vcr_cassettes/Geocoding_Service/retrieves_the_latitude_and_longitude_of_a_given_city.yml')
    lat = cassette[:results].first[:geometry][:location][:lat].to_s
    lng = cassette[:results].first[:geometry][:location][:lng].to_s

    expect(city.name).to eq('denver')
    expect(city.state).to eq('co')
    expect(city.lat).to eq(lat)
    expect(city.lon).to eq(lng)
  end
end

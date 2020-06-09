require 'rails_helper'

describe 'Road trip response' do
  it 'should return the trip information' do
    travel_time = parse_fixture('spec/fixtures/road_trip.json')[:routes]
                  .first[:legs]
                  .first[:duration][:text]
    stub_trip_service
    stub_trip_weather
    user = create(:user)
    new_trip = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": user.api_key
    }
    post '/api/v1/road_trip', params: new_trip, as: :json

    expect(status).to eq(200)
    expect(type).to eq('road_trips')
    expect(attributes[:origin]). to eq(new_trip[:origin])
    expect(attributes[:destination]).to eq(new_trip[:destination])
    expect(attributes[:travel_time]).to eq(travel_time)
    expect(attributes[:arrival_forecast]).to eq('71°, Clouds')
  end
  it 'should return a status 400 if unsuccessful - bad api_key' do
    stub_trip_service
    stub_trip_weather
    user = create(:user)
    new_trip = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": 'jgn983hy48thw9begh98h4539h4'
    }
    post '/api/v1/road_trip', params: new_trip, as: :json

    expect(status).to eq(400)
    expect(message).to eq('Invalid api key')
  end
end

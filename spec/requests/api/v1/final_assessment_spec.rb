require 'rails_helper'

describe 'Food and forecast request for a trip ' do
  before :all do
    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'
    @resp = JSON.parse(response.body, symbolize_names: true)
  end
  it 'should retrieve the end city' do
    expect(@resp[:data][:attributes][:end_location]).to eq("Pueblo, CO, USA")
  end
  it 'should retrieve the estimated travel time' do
    expect(@resp[:data][:attributes][:travel_time]).to eq('1 hour 48 mins')
  end
  it 'should retrieve the name and address of a restaurant that matches the search param' do
    expect(@resp[:data][:attributes][:restaurant][:name]).to eq("Angelo's Pizza Parlor")
    expect(@resp[:data][:attributes][:restaurant][:address]).to eq("105 E Riverwalk, Pueblo 81003")
  end
  it 'should retrieve the forecast at time of arrival' do
    expect(@resp[:data][:attributes][:forecast][:summary]).to eq("clear sky")
    expect(@resp[:data][:attributes][:forecast][:temperature]).to eq(77)
  end
end

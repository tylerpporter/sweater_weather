require 'rails_helper'

describe 'Food and forecast request for a trip ' do
  before :each do
    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'
  end
  it 'should retrieve the end city' do

  end
  it 'should retrieve the estimated travel time' do

  end
  it 'should retrieve the name and address of a restaurant that matches the search param' do

  end
  it 'should retrieve the forecast at time of arrival' do

  end 
end

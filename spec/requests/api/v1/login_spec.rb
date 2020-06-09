require 'rails_helper'

describe 'Login response' do
  before :each do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    @user = User.create(new_user)
  end
  it 'should return status 200 if successful' do
    credentials = {
      "email": "whatever@example.com",
      "password": "password"
    }
    post '/api/v1/sessions', params: credentials, as: :json

    expect(status).to eq(200)
    expect(id).to eq(@user.id)
    expect(attributes[:api_key]).to eq(@user.api_key)
    expect(attributes[:email]).to eq(@user.email)
  end
  it 'should return status 400 if unsuccessful - bad credentials' do
    credentials = {
      "email": "whatever@example.com",
      "password": "password22"
    }
    post '/api/v1/sessions', params: credentials, as: :json 

    expect(status).to eq(400)
    expect(message).to eq('Bad credentials')
  end
end

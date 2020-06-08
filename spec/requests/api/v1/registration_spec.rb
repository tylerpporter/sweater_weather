require 'rails_helper'

describe 'Registration response' do
  it 'should return a status 201 if successful' do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', params: new_user
    resp = JSON.parse(response.body, symbolize_names: true)
    user = User.last

    expect(resp[:status]).to eq(201)
    expect(resp[:body][:data][:type]).to eq('users')
    expect(resp[:body][:data][:id]).to eq(user.id)
    expect(resp[:body][:data][:attributes][:email]).to eq(new_user[:email])
    expect(resp[:body][:data][:attributes][:email]).to eq(user.email)
    expect(resp[:body][:data][:attributes][:api_key]).to eq(user.api_key)
  end
  it 'should return a status 400 if unsuccessful - passwords must match' do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password2"
    }
    post '/api/v1/users', params: new_user

    resp = JSON.parse(response.body, symbolize_names: true)

    expect(User.count).to eq(0)
    expect(resp[:status]).to eq(400)
    expect(resp[:body][:message]).to eq('Passwords must match')
  end
  it 'should return a status 400 if unsuccessful - email exists' do
    create(:user, email: "whatever@example.com")
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', params: new_user

    resp = JSON.parse(response.body, symbolize_names: true)

    expect(User.count).to eq(1)
    expect(resp[:status]).to eq(400)
    expect(resp[:body][:message]).to eq('Email already exists')
  end
  it 'should return a status 400 if unsuccessful - missing field' do
    new_user = {
      "email": '',
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', params: new_user

    resp = JSON.parse(response.body, symbolize_names: true)

    expect(User.count).to eq(0)
    expect(resp[:status]).to eq(400)
    expect(resp[:body][:message]).to eq("Email can't be blank")
  end
end

# Rails Engine

API for [Sweater Weather](https://backend.turing.io/module3/projects/sweater_weather/requirements)
* responses are JSON API 1.0 Compliant

## Deployment

N/A Development only

## Getting Started

- Clone this repository
- Run `rails db:create`
- Run `rails db:migrate`
- Run `rails db:seed`
- Run `bundle install`
- Run `rails s` to start up the local server

## Required API Keys
Add each of these to your `application.yml`
- [GEOCODING_KEY](https://developers.google.com/maps/documentation/geocoding/get-api-key)
- [WEATHER_KEY](https://openweathermap.org/appid)
- [DIRECTIONS_KEY](https://developers.google.com/maps/documentation/directions/start)

### Example Requests
* Weather for a city:
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```
* Background image for a city:
```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```
* Registration:
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json
body:
  {
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "password"
  }
```
* Login:
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json
body:
  {
    "email": "whatever@example.com",
    "password": "password"
  }
```
* Road Trip:
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json
body:
  {
    "origin": "Denver,CO",
    "destination": "Pueblo,CO",
    "api_key": "jgn983hy48thw9begh98h4539h4"
  }
```


## Running the tests

- Run `bundle exec rspec`

## Built With

* [Rails](https://rubyonrails.org/) - Framework
* [RSpec](https://github.com/rspec/rspec-rails) - Test suite

## Author

* [**Tyler Porter**](https://github.com/tylerpporter)

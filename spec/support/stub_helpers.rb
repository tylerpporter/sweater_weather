module StubHelpers
  def stub_geocoding_service
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver%2Bco&key=#{ENV['GEOCODING_KEY']}")
      .with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v1.0.1'
      })
      .to_return(status: 200, body: File.read('spec/fixtures/geocode.json'))
  end

  def stub_open_weather_service(lat, lng)
    stub_request(:get, 'https://api.openweathermap.org/data/2.5/onecall')
      .with(query: {'lat'=> lat, 'lon'=> lng, 'exclude'=>'minutely', 'units'=>'imperial', 'appid'=> ENV['WEATHER_KEY']})
      .to_return(body: File.read('spec/fixtures/open_weather.json'))
  end

  def stub_image_service
    stub_request(:get, 'https://api.teleport.org/api/urban_areas/slug:denver/images')
    .to_return(body: File.read('spec/fixtures/denver_image.json'))
  end

  def stub_trip_service
    stub_request(:get, "https://maps.googleapis.com/maps/api/directions/json?destination=Pueblo,CO&key=#{ENV['DIRECTIONS_KEY']}&origin=Denver,CO")
    .with(headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.0.1'
      }
    )
    .to_return(status: 200, body: File.read('spec/fixtures/road_trip.json'), headers: {})
  end

  def stub_trip_weather
    stub_request(:get, 'https://api.openweathermap.org/data/2.5/onecall')
    .with(query: {'lat'=> '38.2542053', 'lon'=> '-104.6087488', 'exclude'=>'minutely', 'units'=>'imperial', 'appid'=> ENV['WEATHER_KEY']})
    .to_return(body: File.read('spec/fixtures/road_trip_weather.json'))
  end
end

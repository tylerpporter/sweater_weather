module StubHelpers
  def stub_geocoding_service
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver%2Bco&key=AIzaSyCmcheMMrRcDGE0E6bZC0Vmg4goy4_70jg")
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
end

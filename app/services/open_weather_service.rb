class OpenWeatherService
  def initialize(lat, lon, address)
    @lat = lat
    @lon = lon
    @address = address
  end

  def forecast
    {
      address: @address,
      resp: get_json(conn)
    }
  end

  private

  def conn
    Faraday.get('https://api.openweathermap.org/data/2.5/onecall') do |req|
      req.params["lat"] = @lat
      req.params["lon"] = @lon
      req.params["exclude"] = "minutely"
      req.params["units"] = "imperial"
      req.params["appid"] = ENV['WEATHER_KEY']
    end
  end

  def get_json(resp)
    JSON.parse(resp.body, symbolize_names: true)
  end
end

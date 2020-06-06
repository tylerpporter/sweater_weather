class GeocodingService
  def initialize(city, state)
    @city = city
    @state = state
  end

  def lat_lon
    get_json(conn)[:results].first[:geometry][:location]
  end

  private

  def conn
    Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params["address"] = "#{@city}+#{@state}"
      req.params["key"] = ENV['GEOCODING_KEY']
    end
  end

  def get_json(resp)
    JSON.parse(resp.body, symbolize_names: true)
  end
end

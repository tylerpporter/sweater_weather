class GeocodingService
  include Servicable
  def initialize(city, state)
    @city = city
    @state = state
  end

  def lat_lon
    resp = get_json(conn)[:results].first
    {
      location: resp[:geometry][:location],
      address: resp[:formatted_address]
    }
  end

  private

  def conn
    Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params["address"] = "#{@city}+#{@state}"
      req.params["key"] = ENV['GEOCODING_KEY']
    end
  end
end

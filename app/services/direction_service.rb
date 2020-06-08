class DirectionService
  include Servicable
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def directions
    raw = get_json(conn)[:routes].first[:legs].first
    {
      end_location: raw[:end_address],
      travel_time: raw[:duration][:text],
      lat: raw[:end_location][:lat],
      lng: raw[:end_location][:lng]
    }
  end

  private

  def conn
    Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |req|
      req.params[:origin] = @origin
      req.params[:destination] = @destination
      req.params[:key] = ENV['DIRECTIONS_KEY']
    end
  end
end

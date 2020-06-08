class DirectionService
  include Servicable
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def directions
    x = get_json(conn)
    require "pry"; binding.pry
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

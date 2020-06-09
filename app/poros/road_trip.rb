class RoadTrip
  attr_reader :origin, :destination
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def arrival_forecast
    "#{condensed_forecast[:temp]}°, #{condensed_forecast[:description]}"
  end

  def travel_time
    travel_info[:travel_time]
  end

  private

  def condensed_forecast
    {
      temp: full_arrival_forecast.temp,
      description: full_arrival_forecast.weather.main
    }
  end

  def full_arrival_forecast
    @arrival ||= dest_hourly.min_by do |forecast|
      (arrival_time - forecast.dt_unix).abs
    end
  end

  def arrival_time
    dest_current_dt + unix_travel_time
  end

  def dest_current_dt
    @current ||= dest_forecast.current.dt_unix
  end

  def dest_hourly
    @hourly ||= dest_forecast.hourly
  end

  def dest_forecast
    @forecast ||= Forecast.new(forecast_request)
  end

  def forecast_request
    @response ||= OpenWeatherService.new(lat, lng, address).forecast
  end

  def lat
    travel_info[:lat]
  end

  def lng
    travel_info[:lng]
  end

  def address
    travel_info[:end_location]
  end

  def unix_travel_time
    travel_info[:unix_travel_time]
  end

  def travel_info
    @info ||= TripService.new(@origin, @destination).directions
  end
end

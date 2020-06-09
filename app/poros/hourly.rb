class Hourly
  attr_reader :weather, :temp
  def self.forecast(request)
    request.inject([]) do |arr, hourly|
      arr << new(hourly)
      arr
    end
  end

  def initialize(request)
    @raw = request
    @dt = dt
    @temp = temperature
    @icon = icon
    @weather = Weather.new(@raw[:weather])
  end

  def dt_unix
    @raw[:dt]
  end

  private

  def dt
    Time.at(@raw[:dt]).strftime("%I:%M %p")
  end

  def temperature
    @raw[:temp].to_i
  end

  def icon
    Weather.new(@raw[:weather]).icon
  end
end

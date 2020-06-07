class Hourly
  def self.forecast(request)
    request.inject([]) do |arr, hourly|
      arr << new(hourly)
      arr
    end
  end

  def initialize(request)
    @raw = request
    @dt = dt
    @temp = temp
    @icon = icon
  end

  private

  def dt
    Time.at(@raw[:dt]).strftime("%I:%M %p")
  end

  def temp
    @raw[:temp].to_i
  end

  def icon
    Weather.new(@raw[:weather]).icon
  end
end

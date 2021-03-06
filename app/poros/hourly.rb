class Hourly
  def self.forecast(resp)
    resp.inject([]) do |arr, hourly|
      arr << new(hourly)
      arr
    end
  end

  def initialize(resp)
    @raw = resp
  end

  def dt_unix
    @raw[:dt]
  end

  def weather
    @weather ||= Weather.new(@raw[:weather])
  end

  def dt
    Time.at(@raw[:dt]).strftime("%I:%M %p")
  end

  def temp
    @raw[:temp].to_i
  end

  def icon
    weather.icon
  end
end

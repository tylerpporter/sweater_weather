class Daily
  def self.forecast(resp)
    resp.inject([]) do |arr, daily|
      arr << new(daily)
      arr
    end
  end

  def initialize(resp)
    @raw = resp
  end

  def dt
    Time.at(@raw[:dt]).strftime("%A")
  end

  def low
    @raw[:temp][:min].to_i
  end

  def high
    @raw[:temp][:max].to_i
  end

  def precip
    total = 0
    total += @raw[:rain] unless @raw[:rain].nil?
    total += @raw[:snow] unless @raw[:snow].nil?
    "#{total.to_i} mm"
  end

  def description
    weather.main
  end

  def icon
    weather.icon
  end

  private

  def weather
    @weather ||= Weather.new(@raw[:weather])
  end
end

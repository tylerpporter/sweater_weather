class Daily
  attr_reader :high, :low
  def self.forecast(request)
    request.inject([]) do |arr, daily|
      arr << new(daily)
      arr
    end
  end

  def initialize(request)
    @raw = request
    @dt = dt
    @high = max
    @low = min
    @icon = weather.icon
    @description = weather.main
    @precip = precipitation
  end

  private

  def dt
    Time.at(@raw[:dt]).strftime("%A")
  end

  def min
    @raw[:temp][:min].to_i
  end

  def max
    @raw[:temp][:max].to_i
  end

  def precipitation
    total = 0
    total += @raw[:rain] unless @raw[:rain].nil?
    total += @raw[:snow] unless @raw[:snow].nil?
    "#{total.to_i} mm"
  end

  def weather
    Weather.new(@raw[:weather])
  end
end

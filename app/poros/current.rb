class Current
  def initialize(resp, daily)
    @raw = resp
    @daily = daily
  end

  def weather
    Weather.new(@raw[:weather])
  end

  def high
    @daily.high
  end

  def low
    @daily.low
  end

  def dt_unix
    @raw[:dt]
  end

  def dt
    Time.at(@raw[:dt]).strftime("%I:%M %p, %B %d")
  end

  def sunrise
    Time.at(@raw[:sunrise]).strftime("%I:%M %p")
  end

  def sunset
    Time.at(@raw[:sunset]).strftime("%I:%M %p")
  end

  def temp
    @raw[:temp].to_i
  end

  def feels_like
    @raw[:feels_like].to_i
  end

  def humidity
    @raw[:humidity]
  end

  def visibility
    "#{(@raw[:visibility] * 0.00062137).to_i} miles" if @raw[:visibility]
  end

  def uv_index
    "#{@raw[:uvi].to_i} (#{uv_interpret})"
  end

  def uv_interpret
    return 'extreme' if @raw[:uvi] >= 11
    return 'very high' if @raw[:uvi] >= 8
    return 'high' if @raw[:uvi] >= 6
    return 'moderate' if @raw[:uvi] >= 3
    'low'
  end
end

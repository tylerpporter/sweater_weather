class Weather
  attr_reader :icon, :main
  def initialize(raw)
    @main = raw.first[:main]
    @description = raw.first[:description]
    @icon = icon_url(raw)
  end

  private

  def icon_url(raw)
    "http://openweathermap.org/img/wn/#{raw.first[:icon]}@2x.png"
  end
end

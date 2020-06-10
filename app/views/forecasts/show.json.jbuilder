json.status 200
json.body do
  json.data do
    json.id 'null'
    json.type 'forecasts'
    json.attributes do
      json.address @forecast.address
      json.current do
        json.dt @forecast.current.dt
        json.sunrise @forecast.current.sunrise
        json.sunset @forecast.current.sunset
        json.temp @forecast.current.temp
        json.feels_like @forecast.current.feels_like
        json.humidity @forecast.current.humidity
        json.visibility @forecast.current.visibility
        json.uv_index @forecast.current.uv_index
        json.weather @forecast.current.weather
        json.high @forecast.current.high
        json.low @forecast.current.low
      end
      json.hourly @forecast.hourly.each do |hourly|
        json.dt hourly.dt
        json.temp hourly.temp
        json.icon hourly.icon
      end
      json.daily @forecast.daily.each do |daily|
        json.dt daily.dt
        json.low daily.low
        json.high daily.high
        json.icon daily.icon
        json.description daily.description
        json.precip daily.precip
      end
    end
  end
end

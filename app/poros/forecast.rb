class Forecast
  def initialize(resp)
    @resp = resp
  end

  def address
    @resp[:address]
  end

  def current
    Current.new(@resp[:resp][:current], daily.first)
  end

  def hourly
    Hourly.forecast(@resp[:resp][:hourly][4..11])
  end

  def daily
    @daily ||= Daily.forecast(@resp[:resp][:daily])
  end
end

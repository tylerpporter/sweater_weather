class Forecast
  def initialize(request)
    @request = request
  end

  def address
    @request[:address]
  end

  def current
    Current.new(@request[:resp][:current], daily.first)
  end

  def hourly
    Hourly.forecast(@request[:resp][:hourly][4..11])
  end

  def daily
    @daily ||= Daily.forecast(@request[:resp][:daily])
  end
end

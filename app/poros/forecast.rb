class Forecast
  attr_reader :id
  def initialize(request)
    @request = request
    @id = 1
  end

  def address
    @request[:address]
  end

  def current
    @request[:resp][:current]
  end

  def hourly
    @request[:resp][:hourly]
  end

  def daily
    @request[:resp][:daily]
  end
end

module ResponseHelpers
  def daily
    attributes[:daily]
  end

  def hourly
    attributes[:hourly]
  end

  def current
    attributes[:current]
  end

  def id
    data[:id]
  end

  def type
    data[:type]
  end

  def attributes
    data[:attributes]
  end

  def message
    body[:message]
  end

  def data
    body[:data]
  end

  def body
    formatted_response[:body]
  end

  def status
    formatted_response[:status]
  end

  def formatted_response
    @json ||= JSON.parse(response.body, symbolize_names: true)
  end
end

class Trip
  attr_reader :end_location, :travel_time, :lat, :lng
  def initialize(response)
    @end_location = response[:end_location]
    @travel_time = response[:travel_time]
    @lat = response[:lat]
    @lng = response[:lng]
  end
end

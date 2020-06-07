class ImageService
  include Servicable
  def initialize(city)
    @city = city
  end

  def image
    get_json(conn)[:photos].first[:attribution][:source]
  end

  private

  def conn
    Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{@city}/images")
  end
end

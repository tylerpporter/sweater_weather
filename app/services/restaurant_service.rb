class RestaurantService
  include Servicable

  def initialize(type, location)
    @type = type
    @lat = location[:lat]
    @lng = location[:lng]
  end

  private

  def cuisine_hash
    resp = conn.get('cuisines') do |req|
      req.params[:lat] = @lat
      req.params[:lon] = @lng
    end
    get_json(resp)[:cuisines]
  end

  def conn
    Faraday.new('https://developers.zomato.com/api/v2.1') do |f|
      f.headers['user-key'] = ENV['RESTAURANT_KEY']
    end
  end

end

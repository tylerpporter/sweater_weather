class RestaurantService
  include Servicable

  def initialize(type, location)
    @type = type
    @lat = location[:lat]
    @lng = location[:lng]
  end

  def restaurant(type)
    raw = conn.get('search') do |req|
      req.params[:entity_type] = 'zone'
      req.params[:lat] = @lat
      req.params[:lon] = @lng
      req.params[:cuisines] = find_cuisine(type)
    end
    restaurant = get_json(raw)[:restaurants].first[:restaurant]
    {
      name: restaurant[:name],
      address: restaurant[:location][:address]
    }
  end

  private

  def find_cuisine(type)
    @cuisines ||= cuisine_hash
    cuisine = @cuisines.select {|c| c[:cuisine][:cuisine_name].downcase == type}
    cuisine.first[:cuisine][:cuisine_id]
  end

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

class RestaurantService
  include Servicable

  def initialize(type, location)
    @type = type
    @lat = location[:lat]
    @lng = location[:lng]
  end

  def restaurant
    {
      name: restaurant_raw[:name],
      address: restaurant_raw[:location][:address]
    }
  end

  private

  def restaurant_raw
    @raw ||= conn.get('search') do |req|
      req.params[:entity_type] = 'zone'
      req.params[:lat] = @lat
      req.params[:lon] = @lng
      req.params[:cuisines] = find_cuisine
    end
    get_json(@raw)[:restaurants].first[:restaurant]
  end

  def find_cuisine
    @cuisines ||= cuisine_hash
    cuisine = @cuisines.select {|c| c[:cuisine][:cuisine_name].downcase == @type}
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

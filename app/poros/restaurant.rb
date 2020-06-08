class Restaurant
  attr_reader :name, :address 
  def initialize(response)
    @name = response[:name]
    @address = response[:address]
  end
end

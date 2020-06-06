class City < ApplicationRecord
  validates :name, :state, :lat, :lon, :address,  presence: true 
end

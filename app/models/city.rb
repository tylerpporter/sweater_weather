class City < ApplicationRecord
  validates :name, :state, :lat, :lon, presence: true 
end

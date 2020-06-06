class CitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :state, :lat, :lon
end

class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current, :hourly, :daily, :address

  set_id { |id| id = 'null' }
end

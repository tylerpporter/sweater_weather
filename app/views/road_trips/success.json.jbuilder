json.status 200
json.body do
  json.data do
    json.type 'road_trips'
    json.id 'null'
    json.attributes do
      json.origin @road_trip.origin
      json.destination @road_trip.destination
      json.travel_time @road_trip.travel_time
      json.arrival_forecast @road_trip.arrival_forecast
    end
  end
end

FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    state { Faker::Address.state_abbr }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
    address { Faker::Address.full_address }
    image {}
  end
end

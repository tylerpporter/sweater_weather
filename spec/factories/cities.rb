FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    state { Faker::Address.state }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end

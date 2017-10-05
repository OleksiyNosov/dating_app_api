FactoryGirl.define do
  factory :place do
    name { Faker::Pokemon.name }
    city { Faker::Pokemon.location }
    tags { PLACE_TAGS.sample 5 }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    place_id { '' }
  end
end

PLACE_TAGS = %w[
  food fresh pizza hamburger cafe restaurant bar grill pub saloon bistro
  coffee lemonade biscuit juice icecream cocktail music meal drink alcohol
  martini soda dinner beer family sweet
]

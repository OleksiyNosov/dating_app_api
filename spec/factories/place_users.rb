FactoryGirl.define do
  factory :place_user do
    place
    user
    rating { rand 1..5 }
    review { Faker::Friends.quote }
  end
end

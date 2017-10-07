FactoryGirl.define do
  factory :event do
    place
    user
    kind { %i[public_event private_event friends_only].sample }
    title { Faker::RockBand.name }
    description { Faker::RickAndMorty.quote }
    start_time { Faker::Time.between(1.year.ago, Date.today + 1.year) }
  end
end
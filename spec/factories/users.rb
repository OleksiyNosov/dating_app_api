FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation &:password
    birthday { Faker::Date.birthday(18, 30).iso8601 }
    gender { %w[male female].sample }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
  end
end

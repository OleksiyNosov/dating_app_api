require File.join(Rails.root, 'db', 'seeds_helper')

puts "Create Rng"

users_numb       =   100
places_numb      =   100
place_users_numb = 1_000

puts "Create #{ users_numb } users"
users = users_numb.times.map do
  User.create \
    email:      Faker::Internet.email,
    password:   Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    birthday:   Faker::Date.birthday(18, 30).iso8601,
    gender:     gen_gender,
    lat:        gen_lat,
    lng:        gen_lng
end

puts "Create #{ places_numb } places"
places = places_numb.times.map do
  Place.create \
    name:     Faker::Pokemon.name,
    city:     Faker::Pokemon.location,
    tags:     gen_place_tags,
    lat:      gen_lat,
    lng:      gen_lng,
    place_id: gen_place_id
end

puts "Create #{ place_users_numb } place_user (users reviews)"
place_users_numb.times do
  PlaceUser.create \
    user_id:  users.sample.id,
    place_id: places.sample.id,
    rating:   gen_rating,
    review:   gen_quote
end


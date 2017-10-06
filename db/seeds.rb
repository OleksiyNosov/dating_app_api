require File.join(Rails.root, 'db', 'seeds_helper')

puts 'Create Rng'

users_numb       =   100
places_numb      =   100
place_users_numb = 1_000

puts "Create #{ users_numb } users"
users = FactoryGirl.create_list :user, users_numb

puts "Create #{ places_numb } places"
places = FactoryGirl.create_list :place, places_numb

puts "Create #{ place_users_numb } place_user (users reviews)"
place_users_numb.times do
  PlaceUser.create \
    user_id:  users.sample.id,
    place_id: places.sample.id,
    rating:   gen_rating,
    review:   gen_quote
end


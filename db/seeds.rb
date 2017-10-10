require File.join(Rails.root, 'db', 'combinator')

puts 'Create Rng'

users_numb       =   100
places_numb      =   100
place_users_numb = 1_000
events_numb      =   100
invites_numb     = 1_000

puts "Create #{ users_numb } users"
users = FactoryGirl.create_list :user, users_numb

puts "Create #{ places_numb } places"
places = FactoryGirl.create_list :place, places_numb

puts "Create #{ place_users_numb } place_users (user reviews)" # TODO: Rewrite with factories that can handle complex associations
pairs = places.product(users).shuffle

place_users = Array.new place_users_numb do
  pair = pairs.pop

  FactoryGirl.create(:place_user, place: pair[0], user: pair[1])
end

puts "Create #{ events_numb } events"
events = Array.new(events_numb) { FactoryGirl.create(:event, place: places.sample, user: users.sample) }

puts "Create #{ invites_numb } invites" # TODO: Rewrite with factories that can handle complex associations
pairs = events.product(users).shuffle

invites = Array.new invites_numb do
  pair = pairs.pop

  FactoryGirl.create(:invite, event: pair[0], user: pair[1])
end

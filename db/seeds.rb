require File.join(Rails.root, 'db', 'combinator')

puts 'Create Rng'

users_numb       =   100
places_numb      =   100
place_users_numb = 1_000

puts "Create #{ users_numb } users"
users = FactoryGirl.create_list :user, users_numb

puts "Create #{ places_numb } places"
places = FactoryGirl.create_list :place, places_numb

puts "Create #{ place_users_numb } place_user (users reviews)"
combinator = Combinator.new places, users

place_users = place_users_numb.times.map do 
  pair = combinator.delete_random_pair

  FactoryGirl.create(:place_user, place: pair[0], user: pair[1]) 
end

class Place < ApplicationRecord
  acts_as_geolocated
  
  has_many :place_users
  has_many :users, through: :place_users
end
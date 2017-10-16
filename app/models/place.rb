class Place < ApplicationRecord
  has_many :place_users
  has_many :users, through: :place_users
  has_many :events
end

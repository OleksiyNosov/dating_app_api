class Place < ApplicationRecord
  attr_accessor :distance

  has_many :place_users
  has_many :users, through: :place_users
end
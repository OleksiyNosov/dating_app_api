class PlaceUser < ApplicationRecord
  belongs_to :place
  belongs_to :user

  validates :user_id, uniqueness: { scope: :place_id }
  validates :rating, inclusion: { in: 1..5 }
end
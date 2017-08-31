class PlaceUser < ApplicationRecord
  belongs_to :place
  belongs_to :user

  validates :user, uniqueness: { scope: :place }
  validates :rating, inclusion: { in: 1..5 }

  after_commit :recalculate_overall_rating, on: [:create, :update]

  private
  def recalculate_overall_rating
    place.update! overall_rating: place.place_users.average(:rating) 
  end
end
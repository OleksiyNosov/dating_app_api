class AuthToken < ApplicationRecord
  belongs_to :user

  validates :value, presence: true, uniqueness: true

  def expired?
    created_at + 2.weeks < Time.zone.now
  end
end
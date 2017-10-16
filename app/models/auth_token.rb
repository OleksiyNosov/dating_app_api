class AuthToken < ApplicationRecord
  belongs_to :user

  validates :value, presence: true, uniqueness: true

  def expired?
    expired_at < Time.zone.now
  end
end

class AuthToken < ApplicationRecord
  belonds_to :user

  validates :value, uniqueness: true
end

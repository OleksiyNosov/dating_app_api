class AuthToken < ApplicationRecord
  belongs_to :user

  validates :value, presence: true, uniqueness: true
end

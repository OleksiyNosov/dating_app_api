class Event < ApplicationRecord
  enum kind: [:public_event, :private_event, :friends_only]

  belongs_to :place
  belongs_to :user

  validates :place, :user, :title, presence: true
end
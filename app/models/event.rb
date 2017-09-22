class Event < ApplicationRecord
  enum kind: [:public_event, :private_event, :friends_only]

  belongs_to :place
  belongs_to :user

  has_many :invites

  validates :place, :user, :title, presence: true
end
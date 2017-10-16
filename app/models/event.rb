class Event < ApplicationRecord
  enum kind: %i[public_event private_event friends_only]

  belongs_to :place
  belongs_to :user

  has_many :invites, dependent: :destroy
  has_many :invites_attend, -> { attend }, class_name: :Invite
  has_many :people_attend, through: :invites_attend, class_name: :User, source: :user

  validates :place, :user, :title, presence: true
end

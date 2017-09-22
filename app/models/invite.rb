class Invite < ApplicationRecord
  enum respond: [:no_respond, :attended, :not_attended]

  belongs_to :event
  belongs_to :user

  validates :event, :user, presence: true
end

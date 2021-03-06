class Invite < ApplicationRecord
  enum respond: %i[no_respond attend not_attend]

  belongs_to :event
  belongs_to :user

  validates :event, :user, presence: true
end

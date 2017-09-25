class Event < ApplicationRecord
  enum kind: [:public_event, :private_event, :friends_only]

  belongs_to :place
  belongs_to :user

  has_many :invites

  validates :place, :user, :title, presence: true

  def new_invite_if_not_exist invited_user
    invites.build user: invited_user unless invites.find_by user: invited_user
  end
end
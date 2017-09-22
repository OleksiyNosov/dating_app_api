class Event < ApplicationRecord
  enum kind: [:public_event, :private_event, :friends_only]

  belongs_to :place
  belongs_to :user

  has_many :invites

  validates :place, :user, :title, presence: true

  def create_invite_if_not_exist invited_user
    create_invite(invited_user) unless invite_exist? invited_user
  end

  def invite_exist? invited_user
    !!Invite.find_by(event: self, user: invited_user)
  end

  def create_invite invited_user
    Invite.create event: self, user: invited_user, respond: :no_respond 
  end
end
class User < ApplicationRecord
  has_secure_password

  enum gender: %i[male female]

  has_many :auth_tokens, dependent: :destroy
  has_many :place_users
  has_many :places, through: :place_users
  has_many :events
  has_many :invites

  has_attached_file :avatar, styles: { thumb: '300x300#' }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  after_commit :create_auth_token, on: :create

  def create_auth_token
    AuthToken.create value: SecureRandom.uuid, user: self, expired_at: Time.zone.now + 2.weeks
  end
end

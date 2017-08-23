class User < ApplicationRecord
  has_secure_password

  has_many :auth_tokens, dependent: :destroy

  enum gender: [:male, :female]

  validates :email, presence: true, uniqueness: { case_sensetive: false }, email: true

  def create_auth_token
    AuthToken.create value: SecureRandom.uuid, user_id: id
  end
end

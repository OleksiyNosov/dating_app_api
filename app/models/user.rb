class User < ApplicationRecord
  has_secure_password

  has_many :auth_tokens, dependent: :destroy

  has_attached_file :avatar, styles: { thumb: '300x300#' }

  enum gender: [:male, :female]

  validates :email, presence: true, uniqueness: { case_sensetive: false }, email: true

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/ 

  def create_auth_token
    AuthToken.create value: SecureRandom.uuid, user_id: id
  end
end

class User < ApplicationRecord
  has_secure_password

  enum gender: [:male, :female]
  
  has_many :auth_tokens, dependent: :destroy
  has_many :place_users
  has_many :places, through: :place_users

  has_attached_file :avatar, styles: { thumb: '300x300#' }

  validates :email, presence: true, uniqueness: { case_sensetive: false }, email: true

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/ 

  after_commit :create_auth_token, on: :create

  def create_auth_token
    loop do
      uuid = SecureRandom.uuid

      unless AuthToken.find_by value: uuid
        AuthToken.create value: uuid, user_id: id
        break
      end
    end
  end
end

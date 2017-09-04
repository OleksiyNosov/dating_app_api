class User < ApplicationRecord
  include EarthDistance

  has_secure_password

  enum gender: [:male, :female]
  
  has_many :auth_tokens, dependent: :destroy
  has_many :place_users
  has_many :places, through: :place_users

  has_attached_file :avatar, styles: { thumb: '300x300#' }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/ 

  after_commit :create_auth_token, on: :create

  def create_auth_token
    AuthToken.create value: SecureRandom.uuid, user: self
  end

  def distance_to place
    earth_distance_between self.lat, self.lng, place.lat, place.lng
  end
end

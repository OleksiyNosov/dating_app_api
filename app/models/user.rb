class User < ApplicationRecord
  has_secure_password

  enum :gender, [:male, :female]

  validates :email, presence: true, uniqueness: { case_sensetive: false }, email: true
end

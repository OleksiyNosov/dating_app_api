require 'rails_helper'

RSpec.describe User, type: :model do
  it { should be_an ApplicationRecord }

  it { should have_secure_password }

  it { should have_many(:auth_tokens).dependent(:destroy) }

  it { should have_many(:place_users) }

  it { should have_many(:places).through(:place_users) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :email }

  it { should_not allow_value('test').for(:email) }

  it { should allow_value('test@test.com').for(:email) }

  it { should define_enum_for(:gender).with([:male, :female]) }

  it { should have_attached_file :avatar }

  it { should validate_attachment_content_type(:avatar).
              allowing('image/png', 'image/gif').
              rejecting('text/plain', 'text/xml') }
end

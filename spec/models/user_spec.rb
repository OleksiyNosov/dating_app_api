require 'rails_helper'

RSpec.describe User, type: :model do
  it { should be_an ApplicationRecord }

  it { should have_secure_password }

  it { should have_many(:auth_tokens).dependent(:destroy) }

  it { should have_many(:place_users) }

  it { should have_many(:places).through(:place_users) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should_not allow_value('test').for(:email) }

  it { should allow_value('test@test.com').for(:email) }

  it { should define_enum_for(:gender).with([:male, :female]) }

  it { should have_attached_file :avatar }

  it { should validate_attachment_content_type(:avatar).
              allowing('image/png', 'image/gif').
              rejecting('text/plain', 'text/xml') }

  describe 'create_auth_token' do
    let(:value) { 'XXXX-YYYY-ZZZZ' }

    let(:created_at_time) { Time.new(2010, 7, 16) }

    let(:valid_token_time) { 2.weeks }

    let(:expired_at_time) { created_at_time + valid_token_time }

    let(:params) { { value: value, user: subject, expired_at: expired_at_time } }

    let(:auth_token) { stub_model AuthToken }

    before { expect(SecureRandom).to receive(:uuid).and_return(value) }

    before do 
      #
      # Time.zone.now -> created_at_time
      #
      expect(Time).to receive(:zone) do
        double.tap { |a| expect(a).to receive(:now).and_return(created_at_time) }
      end 
    end

    before { expect(created_at_time).to receive(:+).with(valid_token_time).and_return(expired_at_time) }

    before { expect(AuthToken).to receive(:create).with(params).and_return(auth_token) }

    its(:create_auth_token) { should eq auth_token }
  end
end
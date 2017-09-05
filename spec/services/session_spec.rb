require 'rails_helper'

RSpec.describe Session do
  describe '#initialize' do
    let(:user) { stub_model User }

    let(:params) { { user: user, email: 'test@test.com', password: 'qwerty' } }

    xit { }
  end

  describe '#save!' do
    let(:password) { 'qwerty' }

    let(:user) { stub_model User, valid?: true }

    let(:auth_token) { stub_model AuthToken }

    before { expect(subject).to receive(:user).and_return(user) }

    before { expect(subject).to receive(:password).and_return(password) }

    before do 
      expect(subject).to receive(:user) do
        double.tap { |a| expect(a).to receive(:authenticate).with(password) }
      end
    end

    before { expect(subject).to receive(:user).and_return(user) }

    before { expect(user).to receive(:create_auth_token).and_return(auth_token) }

    xit(:save!) { should eq auth_token }
  end

  describe '#destroy!' do
    let(:user) { stub_model User }

    before do 
      expect(user).to receive(:auth_tokens) do
        double.tap { |a| expect(a).to receive(:destroy_all) }
      end
    end

    xit { }
  end

  describe '#auth_token' do
    let(:user) { stub_model User }

    let(:auth_token) { stub_model AuthToken }

    before do
      expect(user).to receive(:auth_tokens) do
        double.tap { |a| expect(a).to receive(:last).and_return(auth_token) }
      end
    end

    xit(:auth_token) { should eq auth_token }
  end

  describe '#user' do
    let(:email_value) { 'test@test.com' }

    let(:user) { stub_model User }

    before { expect(subject).to receive(:email).and_return(email_value) }

    before { expect(User).to receive(:find_by).with(email: email_value).and_return(user) }

    its(:user) { should eq user }
  end
end
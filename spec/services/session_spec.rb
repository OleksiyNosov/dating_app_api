require 'rails_helper'

RSpec.describe Session do
  let(:session) { Session.new email: 'test@test.com', password: 'qwerty' }

  subject { session }

  describe '#initialize' do
    let(:user) { stub_model User }

    let(:params) { { user: user, email: 'test@test.com', password: 'qwerty' } }

    its(:email) { should eq 'test@test.com' }

    its(:password) { should eq 'qwerty' }

    it { expect { Session.new params }.to_not raise_error }
  end

  describe '#save!' do
    context 'valid' do
      let(:auth_token) { stub_model AuthToken }

      before { expect(subject).to receive(:valid?).and_return true }

      before do
        #
        # => user.create_auth_token
        #
        expect(subject).to receive(:user) do
          double.tap { |a| expect(a).to receive(:create_auth_token).and_return auth_token }
        end
      end

      its(:save!) { should eq auth_token }
    end

    context 'not valid' do
      before { expect(subject).to receive(:valid?).and_return false }

      it { expect { subject.save! }.to raise_error ActiveModel::StrictValidationFailed }
    end
  end

  describe '#destroy!' do
    before do
      #
      # => user.auth_token.destroy_all
      #
      expect(subject).to receive(:user) do
        double.tap do |a| 
          expect(a).to receive(:auth_tokens) do
            double.tap { |b| expect(b).to receive(:destroy_all) }
          end
        end
      end
    end

    it { expect { subject.destroy! }.to_not raise_error }
  end

  describe '#auth_token' do
    context 'user exist' do
      let(:auth_token) { stub_model AuthToken }

      before { expect(subject).to receive(:user).and_return true }

      before do
        #
        # => user.auth_tokens.last
        #
        expect(subject).to receive(:user) do
          double.tap do |a|
            expect(a).to receive(:auth_tokens) do
              double.tap { |b| expect(b).to receive(:last).and_return auth_token }
            end 
          end
        end
      end

      its(:auth_token) { should eq auth_token }
    end

    context 'user not exist' do
      before { expect(subject).to receive(:user).and_return false }

      its(:auth_token) { should eq nil }
    end
  end

  describe '#user' do
    let(:email_value) { 'test@test.com' }

    let(:user) { stub_model User }

    before { expect(subject).to receive(:email).and_return(email_value) }

    before { expect(User).to receive(:find_by).with(email: email_value).and_return(user) }

    its(:user) { should eq user }
  end
end
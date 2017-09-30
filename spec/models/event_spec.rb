require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should be_an ApplicationRecord }

  it { should belong_to :place }

  it { should belong_to :user }

  it { should have_many :invites }

  it { should validate_presence_of :place }
  
  it { should validate_presence_of :user }
  
  it { should validate_presence_of :title }

  describe '#new_invite_if_not_exist' do
    let(:invited_user) { stub_model User }

    context 'user not exist' do
      before do
        #
        # => invites.find_by
        #
        expect(subject).to receive(:invites) do
          double.tap { |a| expect(a).to receive(:find_by).with(user: invited_user).and_return false }
        end
      end

      before do
        #
        # => invites.build
        #
        expect(subject).to receive(:invites) do
          double.tap { |a| expect(a).to receive(:build).with(user: invited_user) }
        end
      end

      it { expect { subject.new_invite_if_not_exist invited_user }.to_not raise_error }
    end

    context 'user already exist' do
      before do
        #
        # => invites.find_by
        #
        expect(subject).to receive(:invites) do
          double.tap { |a| expect(a).to receive(:find_by).with(user: invited_user).and_return true }
        end
      end

      it { expect { subject.new_invite_if_not_exist invited_user }.to_not raise_error }
    end
  end
end

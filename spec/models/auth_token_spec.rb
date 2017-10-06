require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  it { is_expected.to be_an ApplicationRecord }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of :value }

  it { is_expected.to validate_uniqueness_of :value }

  describe '#expired?' do
    let(:time_now) { Time.new 2010, 10, 10 }

    before do 
      #
      # => Time.zone.now
      #
      expect(Time).to receive(:zone) do
        double.tap { |a| expect(a).to receive(:now).and_return time_now }
      end 
    end
    
    context 'expired' do
      let(:time_expired_at) { Time.new 2010, 10, 9 }

      before { expect(subject).to receive(:expired_at).and_return time_expired_at }

      its(:expired?) { should eq true }
    end

    context 'not expired' do
      let(:time_expired_at) { Time.new 2010, 10, 11 }

      before { expect(subject).to receive(:expired_at).and_return time_expired_at }

      its(:expired?) { should eq false }
    end
  end
end
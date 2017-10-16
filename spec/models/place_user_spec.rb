require 'rails_helper'

RSpec.describe PlaceUser, type: :model do
  it { is_expected.to be_an ApplicationRecord }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to belong_to(:place) }

  it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }

  describe '#recalculate_overall_rating' do
    let(:overall_rating) { 3.5 }

    let(:place_users) { double }

    let(:place) { stub_model Place }

    before { expect(subject).to receive(:place).and_return(place) }

    before do
      #
      # -> place.place_users.average
      #
      expect(place).to receive(:place_users) do
        double.tap { |a| expect(a).to receive(:average).with(:rating).and_return(overall_rating) }
      end
    end

    before { expect(subject).to receive(:place).and_return(place) }

    before { expect(place).to receive(:update!).with(overall_rating: overall_rating).and_return(place) }

    its(:recalculate_overall_rating) { is_expected.to eq place }
  end
end

require 'rails_helper'

RSpec.describe PlaceUserDecorator do
  let(:place_user) { stub_model PlaceUser, rating: 4 }

  describe '#as_json' do
    context do
      subject { place_user.decorate }

      its('as_json.symbolize_keys') { is_expected.to eq place: place_user.place }
    end

    context 'user_user_ratings' do
      subject { place_user.decorate(context: { user_user_ratings: true }) }

      its('as_json.symbolize_keys') do
        is_expected.to eq \
        rating: 4,
        place:  place_user.place
      end
    end
  end
end
require 'rails_helper'

RSpec.describe PlaceDecorator do
  let(:place) do
    stub_model Place,
               id: 3,
               name: 'Mafia',
               city: 'Vinnitsia',
               place_id: '',
               tags: %w[beer pizza],
               overall_rating: 4.6,
               lat: 136.5,
               lng: 30.9
  end

  describe '#ratings' do
    subject { place.decorate context: { place_user_ratings: true } }

    let(:user) { stub_model User }

    let(:ratings) { { user: user, rating: 4 } }

    before do
      #
      # => place_users.map
      #
      expect(subject).to receive(:place_users) do
        double.tap { |a| expect(a).to receive(:map).and_return ratings }
      end
    end

    its(:ratings) { is_expected.to eq user: user, rating: 4 }
  end

  describe '#distance' do
    subject { place.decorate context: { with_distance: true } }

    context 'distance is in query' do
      before do
        #
        # => object.respond_to?
        #
        expect(subject).to receive(:object) do
          double.tap { |a| expect(a).to receive(:respond_to?).with(:distance).and_return true }
        end
      end

      before do
        #
        # => object.distance
        #
        expect(subject).to receive(:object) do
          double.tap { |a| expect(a).to receive(:distance).and_return 2.5 }
        end
      end

      before do
        #
        # => km_to_m.round
        #
        expect(subject).to receive(:km_to_m).with(2.5) do
          double.tap { |a| expect(a).to receive(:round).with(2).and_return 2500 }
        end
      end

      xit(:distance) { is_expected.to eq 2500 }
    end

    context 'distance is not is query' do
      before do
        #
        # => object.respond_to?
        #
        expect(subject).to receive(:object) do
          double.tap { |a| expect(a).to receive(:respond_to?).with(:distance).and_return false }
        end
      end

      its(:distance) { is_expected.to eq nil }
    end
  end

  describe '#as_json' do
    context do
      subject { place.decorate }

      its('as_json.symbolize_keys') do
        is_expected.to eq \
          id: 3,
          name: 'Mafia',
          city: 'Vinnitsia',
          place_id: '',
          tags: %w[beer pizza],
          overall_rating: 4.6,
          coords: { lat: 136.5, lng: 30.9 }
      end
    end

    context 'place_user_ratings' do
      subject { place.decorate(context: { place_user_ratings: true }) }

      its('as_json.symbolize_keys') do
        is_expected.to eq \
          id: 3,
          name: 'Mafia',
          city: 'Vinnitsia',
          place_id: '',
          tags: %w[beer pizza],
          overall_rating: 4.6,
          coords: { lat: 136.5, lng: 30.9 },
          ratings: []
      end
    end

    context 'with_distance' do
      subject { place.decorate(context: { with_distance: true }) }

      let(:distance) { 3.6 }

      before { expect(subject).to receive(:distance).and_return(distance) }

      its('as_json.symbolize_keys') do
        is_expected.to eq \
          id: 3,
          name: 'Mafia',
          city: 'Vinnitsia',
          place_id: '',
          tags: %w[beer pizza],
          overall_rating: 4.6,
          coords: { lat: 136.5, lng: 30.9 },
          distance: distance
      end
    end
  end
end

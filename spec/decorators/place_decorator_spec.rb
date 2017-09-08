require 'rails_helper'

RSpec.describe PlaceDecorator do
  let(:place) do 
    stub_model Place, 
    id: 3, 
    name: 'Mafia', 
    city: 'Vinnitsia',
    place_id: '', 
    tags: ['beer', 'pizza'], 
    overall_rating: 4.6,
    lat: 136.5,
    lng: 30.9
  end

  describe '#as_json' do
    context do
      subject { place.decorate }

      its('as_json.symbolize_keys') do
        should eq \
        id: 3, 
        name: 'Mafia', 
        city: 'Vinnitsia',
        place_id: '', 
        tags: ['beer', 'pizza'], 
        overall_rating: 4.6,
        coords: { lat: 136.5, lng: 30.9 }
      end
    end

    context 'place_user_ratings' do
      subject { place.decorate(context: { place_user_ratings: true }) }

      its('as_json.symbolize_keys') do
        should eq \
        id: 3, 
        name: 'Mafia', 
        city: 'Vinnitsia',
        place_id: '', 
        tags: ['beer', 'pizza'], 
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
        should eq \
        id: 3, 
        name: 'Mafia', 
        city: 'Vinnitsia',
        place_id: '', 
        tags: ['beer', 'pizza'], 
        overall_rating: 4.6,
        coords: { lat: 136.5, lng: 30.9 },
        distance: distance
      end
    end
  end
end
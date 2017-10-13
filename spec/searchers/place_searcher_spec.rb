require 'rails_helper'

RSpec.describe PlaceSearcher do
  subject { PlaceSearcher.new city: 'Vinnytsia' }

  describe '#initialize_results' do
    before { expect(Place).to receive(:all).and_return :all }

    its(:initialize_results) { is_expected.to eq :all }
  end

  describe '#search_by_city' do
    context 'city is present' do
      before do
        #
        # => city.present?
        #
        expect(subject).to receive(:present?).and_return true
      end

      before { expect(subject).to receive(:where).with(city: 'Vinnytsia').and_return :result }

      xit(:search_by_city) { is_expected.to eq :result }
    end

    context 'city is not present' do
      before do
        #
        # => city.present?
        #
        expect(subject).to receive(:present?).and_return false
      end

      xit(:search_by_city) { is_expected.to eq nil }
    end
  end
end

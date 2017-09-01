require 'rails_helper'

RSpec.describe Api::PlacesController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    let(:params) { { city: 'London', tags: ['beer', 'pizza'] } }

    before { expect(subject).to receive(:authenticate) }

    before { expect(PlaceSearcher).to receive(:search).with(params).and_return(:collection) }

    before { process :index, method: :get, params: params, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '1' } }

    let(:place) { stub_model Place }

    before { expect(subject).to receive(:authenticate) }

    before { expect(Place).to receive(:find).with('1').and_return(place) }

    its(:resource) { should eq place }

    before { process :show, method: :get, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#create' do
    let(:place_params) { { name: 'Mafia', city: 'Vinnitsia' } }

    let(:params) { { place: place_params } }

    let(:place) { stub_model Place }

    before { expect(subject).to receive(:authenticate) }

    before { expect(Place).to receive(:new).with(permit! place_params).and_return(place) }

    before { expect(place).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end

  describe '#update' do
    let(:place_params) { { name: 'Black Cat White Cat', city: 'Vinnitsia' } }

    let(:params) { { place: place_params, id: '1' } }

    let(:place) { stub_model Place }

    before { expect(subject).to receive(:authenticate) }

    before { expect(Place).to receive(:find).with('1').and_return(place) }

    before { expect(place).to receive(:update!).with(permit! place_params) }

    before { process :update, method: :patch, params: params, format: :json }

    it { should render_template :update }
  end
end
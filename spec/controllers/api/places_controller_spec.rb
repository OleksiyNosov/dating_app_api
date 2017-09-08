require 'rails_helper'

RSpec.describe Api::PlacesController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    let(:params) { { city: 'London', tags: ['beer', 'pizza'], range: '6' } }

    before { sign_in }

    before { process :index, method: :get, params: params, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '1' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#create' do
    let(:place_params) { { name: 'Mafia', city: 'Vinnitsia' } }

    let(:params) { { place: place_params } }

    let(:place) { stub_model Place }

    before { sign_in }

    before { expect(Place).to receive(:new).with(permit! place_params).and_return(place) }

    before { expect(place).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end

  describe '#update' do
    let(:place_params) { { name: 'Black Cat White Cat', city: 'Vinnitsia' } }

    let(:params) { { place: place_params, id: '1' } }

    let(:place) { stub_model Place }

    before { sign_in }

    before { expect(Place).to receive(:find).with('1').and_return(place) }

    before { expect(place).to receive(:update!).with(permit! place_params) }

    before { process :update, method: :patch, params: params, format: :json }

    it { should render_template :update }
  end

  describe '#collection' do
    let(:params) { { range: '6' } }

    let(:user) { { user: { lat: 1.5, lng: 0.5 } } }

    let(:merged_params) { { params: params.merge(user) } }

    let(:place_searcher) { PlaceSearcher.new }

    before { expect(subject).to receive(:current_user).and_return(user) }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(params).to receive(:merge).with(user).and_return(merged_params) }

    before { expect(place_searcher).to receive(:search).with(merged_params).and_return(:collection) }

    xit(:collection) { should eq :collection }
  end

  describe '#resource' do
    let(:params) { '1' }

    let(:place) { stub_model Place }

    before do 
      #
      # params[:id] -> 1
      #
      expect(subject).to receive(:params) do
        double.tap { |a| expect(a).to receive(:[]).with(:id).and_return(params) }
      end 
    end

    before { expect(Place).to receive(:find).with(params).and_return(place) }

    its(:resource) { should eq place }
  end
end
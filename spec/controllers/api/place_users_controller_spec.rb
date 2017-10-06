require 'rails_helper'

RSpec.describe Api::PlaceUsersController, type: :controller do
  it { is_expected.to be_an ApplicationController }

  describe '#show' do
    let(:params) { { place_user: { }, id: '2', place_id: '3' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { is_expected.to render_template :show }
  end

  describe '#create' do
    let(:place_user_params) { { rating: '1', review: 'Beer is shit!' } }    

    let(:params) { { place_user: place_user_params, place_id: '3' } }

    let(:place_user) { stub_model PlaceUser }

    let(:parent) { stub_model Place }

    let(:user) { double }

    before { sign_in user }

    before { expect(Place).to receive(:find).with('3').and_return(parent) }

    before do 
      #
      # parent.place_users.build -> place_user
      #
      expect(parent).to receive(:place_users) do
        double.tap do |a| 
          expect(a).to receive(:build).with(permit! place_user_params.merge(user: user)).and_return(place_user) 
        end
      end 
    end

    before { expect(place_user).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { is_expected.to render_template :create }
  end

  describe '#update' do
    let(:place_user_params) { { rating: '5', review: 'Martini is good!' } }

    let(:params) { { place_user: place_user_params, id: '2', place_id: '3' } }

    let(:place_user) { stub_model PlaceUser }

    let(:parent) { stub_model Place } 

    let(:user) { double }

    before { sign_in user }

    before { expect(Place).to receive(:find).with('3').and_return(parent) }

    before do
      #
      # parent.place_users.find_by -> place_user
      #
      expect(parent).to receive(:place_users) do
        double.tap { |a| expect(a).to receive(:find_by).with(user: user).and_return(place_user) }
      end
    end

    before { expect(place_user).to receive(:update!).with(permit! place_user_params) }

    before { process :update, method: :patch, params: params, format: :json }

    it { is_expected.to render_template :update }
  end

  describe '#resource' do
    let(:place_user) { stub_model PlaceUser }

    let(:user) { stub_model User }

    before { expect(subject).to receive(:current_user).and_return(user) }

    before do
      #
      # parent.place_users.find_by -> place_user
      # 
      expect(subject).to receive(:parent) do
        double.tap do |a| 
          expect(a).to receive(:place_users) do 
            double.tap { |b| expect(b).to receive(:find_by).with(user: user).and_return(place_user) }
          end         
        end
      end
    end

    its(:resource) { should eq place_user }
  end

  describe '#parent' do
    let(:parent) { stub_model Place }

    let(:params) { '3' }

    before do
      #
      # params[:place_id] -> 3
      #
      expect(subject).to receive(:params) do
        double.tap { |a| expect(a).to receive(:[]).with(:place_id).and_return(params) }
      end 
    end

    before { expect(Place).to receive(:find).with(params).and_return(parent) }

    its(:parent) { should eq parent }
  end
end
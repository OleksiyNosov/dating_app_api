require 'rails_helper'

RSpec.describe Api::UserRatingsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    context 'parent is place' do
      let(:params) { { place_id: '3' } }

      before { sign_in }

      before { process :index, method: :get, params: params, format: :json }

      it { should render_template :index }
    end

    context 'parent is user' do
      let(:params) { { user_id: '2' } }

      before { sign_in }

      before { process :index, method: :get, params: params, format: :json }

      it { should render_template :index }
    end
  end

  describe '#collection' do
    before { expect(subject).to receive(:parent).and_return(:collection) }

    its(:collection) { should eq :collection }
  end

  describe '#parent' do
    

    context 'parent is place' do
      before do 
        #
        # params[:user_id]
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:user_id) }
        end 
      end

      let(:parent_id) { '3' }

      let(:place) { stub_model Place }

      before do 
        #
        # params[:place_id] -> 3
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:place_id).and_return(parent_id) }
        end 
      end

      before { expect(Place).to receive(:find).with(parent_id).and_return(place) }

      its(:parent) { should eq place }
    end

    context 'parent is user' do
      before do 
        #
        # params[:user_id]
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:user_id).and_return(nil) }
        end 
      end

      let(:parent_id) { '2' }

      let(:user) { stub_model User }

      before do
        #
        # params[:user_id] -> 2
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:user_id).and_return(parent_id) }
        end
      end      

      before { expect(User).to receive(:find).with(parent_id).and_return(user) }

      xit(:parent) { should eq user }
    end
  end
end
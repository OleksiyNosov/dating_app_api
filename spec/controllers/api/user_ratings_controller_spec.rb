require 'rails_helper'

RSpec.describe Api::UserRatingsController, type: :controller do
  it { is_expected.to be_an ApplicationController }

  describe '#index' do
    context 'parent is place' do
      let(:params) { { place_id: '3' } }

      before { sign_in }

      before { process :index, method: :get, params: params, format: :json }

      it { is_expected.to render_template :index }
    end

    context 'parent is user' do
      let(:params) { { user_id: '2' } }

      before { sign_in }

      before { process :index, method: :get, params: params, format: :json }

      it { is_expected.to render_template :index }
    end
  end

  describe '#collection' do
    before { expect(subject).to receive(:parent).and_return(:collection) }

    its(:collection) { is_expected.to eq :collection }
  end

  describe '#parent' do
    context 'parent is place' do
      let(:parent_id) { '3' }

      let(:place) { stub_model Place }

      before do
        #
        # params[:user_id] -> false
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:user_id).and_return false }
        end
      end

      before do
        #
        # params[:place_id] -> 3
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:place_id).and_return parent_id }
        end
      end

      before { expect(Place).to receive(:find).with(parent_id).and_return place }

      its(:parent) { is_expected.to eq place }
    end

    context 'parent is user' do
      let(:parent_id) { '2' }

      let(:user) { stub_model User }

      before do
        #
        # params[:user_id] -> true
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:user_id).and_return true }
        end
      end

      before do
        #
        # params[:user_id] -> 2
        #
        expect(subject).to receive(:params) do
          double.tap { |a| expect(a).to receive(:[]).with(:user_id).and_return parent_id }
        end
      end

      before { expect(User).to receive(:find).with(parent_id).and_return user }

      its(:parent) { is_expected.to eq user }
    end
  end
end

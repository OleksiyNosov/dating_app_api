require 'rails_helper'

RSpec.describe Api::UserRatingsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    context 'parent is place' do
      let(:params) { { place_id: '3' } }

      let(:parent) { stub_model Place }

      before { expect(subject).to receive(:authenticate) }

      before { expect(Place).to receive(:find).with('3').and_return(parent) }

      before { process :index, method: :get, params: params, format: :json }

      it { should render_template :index }
    end

    context 'parent is user' do
      let(:params) { { user_id: '2' } }

      let(:parent) { stub_model User }

      before { expect(subject).to receive(:authenticate) }

      before { expect(User).to receive(:find).with('2').and_return(parent) }

      before { process :index, method: :get, params: params, format: :json }

      it { should render_template :index }
    end
  end
end
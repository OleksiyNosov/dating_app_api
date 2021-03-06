require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  it { is_expected.to be_an ApplicationController }

  describe '#index' do
    before { sign_in }

    before { process :index, method: :get, format: :json }

    it { is_expected.to render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '1' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { is_expected.to render_template :show }
  end

  describe '#collection' do
    before { expect(User).to receive(:all).and_return(:collection) }

    its(:collection) { is_expected.to eq :collection }
  end

  describe '#resource' do
    let(:params) { '1' }

    let(:user) { stub_model User }

    before do
      #
      # params[:id] -> 1
      #
      expect(subject).to receive(:params) do
        double.tap { |a| expect(a).to receive(:[]).with(:id).and_return(params) }
      end
    end

    before { expect(User).to receive(:find).with(params).and_return(user) }

    its(:resource) { is_expected.to eq user }
  end
end

require 'rails_helper'

RSpec.describe Api::AvatarsController, type: :controller do
  it { is_expected.to be_an ApplicationController }

  describe '#create' do
    let(:params) { { avatar: 'avatar' } }

    let(:user) { double }

    before { sign_in user }

    before { expect(user).to receive(:update!).with(permit! params) }

    before { process :create, method: :post, params: params }

    it { is_expected.to respond_with :ok }
  end

  describe '#destroy' do
    let(:params) { { user_id: '2' } }

    let(:user) { double }

    before { sign_in user }

    before { expect(user).to receive(:avatar=).with(nil) }

    before { expect(user).to receive(:save!) }

    before { process :destroy, method: :delete, params: params, format: :json }

    it { is_expected.to respond_with :no_content }
  end
end

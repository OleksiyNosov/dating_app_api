require 'rails_helper'

RSpec.describe Api::AvatarsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:params) { { avatar: 'avatar' } }

    let(:user) { stub_model User }

    before { expect(subject).to receive(:authenticate) }

    before { expect(subject).to receive(:resource).and_return(user) }

    before { expect(user).to receive(:update!).with(permit! params) }

    before { process :create, method: :post, params: params }

    it { should respond_with :ok }
  end
end
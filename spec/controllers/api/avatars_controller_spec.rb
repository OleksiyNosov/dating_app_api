require 'rails_helper'

RSpec.describe Api::AvatarsController, type: :controller do
  it { should be_an ApplicationController }

  puts "\nAvatarsController#create"
  describe '#create' do
    let(:avatar) { fixture_file_upload('files/image.jpg', 'image/jpg') }

    let(:params) { { avatar: avatar } }

    let(:user) { stub_model User }

    before { expect(subject).to receive(:authenticate) }

    before { expect(subject).to receive(:resource).and_return(user) }

    before { expect(user).to receive(:update!).with(params) }

    before { process :create, method: :post, params: params }

    it { should render_template :create }
  end
end
require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    before { sign_in }

    before { expect(User).to receive(:all).and_return(:collection) }

    its(:collection) { should eq :collection }

    before { process :index, method: :get, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '1' } }

    let(:user) { double }

    before { sign_in user }

    before { expect(User).to receive(:find).with('1').and_return(user) }

    its(:resource) { should eq user }

    before { process :show, method: :get, params: params, format: :json }

    it { should render_template :show }
  end
end
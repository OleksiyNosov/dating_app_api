require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do
  it { should be_an ApplicationController }

  describe '#show' do
    let(:user) { double }

    before { sign_in user }

    its(:resource) { should eq user }
    
    before { process :show, method: :get, format: :json }

    it { should render_template :show }
  end

  describe '#create' do
    let(:user_params) { { email: 'test@test.com', password: 'qwerty', password_confirmation: 'qwerty' } }

    let(:params) { { user: user_params } }

    let(:user) { double }

    before { expect(User).to receive(:new).with(permit! user_params).and_return(user) }

    before { expect(user).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end

  describe '#update' do
    let(:user_params) { { first_name: 'test', last_name: 'test' } }

    let(:params) { { user: user_params } }

    let(:user) { double }

    before { sign_in user }

    before { expect(user).to receive(:update!).with(permit! user_params) }

    before { process :update, method: :patch, params: params, format: :json }

    it { should render_template :update }
  end
end
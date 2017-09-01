require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it { should be_an ApplicationController }

  puts "\nSessionsController#create problem"
  describe '#create' do
    let(:session_params) { { email: 'test@test.com', password: 'qwerty' } }

    let(:params) { { session: session_params } }

    let(:session) { stub_model Session }

    before { expect(Session).to receive(:new).with(permit! session_params).and_return(session) }

    before { expect(session).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    # it { should render_template :create }
  end

  puts "SessionsController#destroy problem"
  describe '#destroy' do
    let(:session) { stub_model Session }

    before { expect(subject).to receive(:authenticate) }

    before { expect(subject).to receive(:resource).and_return(session) }

    before { expect(session).to receive(:destroy!) }

    before { process :destroy, method: :delete, format: :json }

    # its(:head) { should eq :no_context }
  end
end
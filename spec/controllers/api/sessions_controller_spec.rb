require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:session_params) { { email: 'test@test.com', password: 'qwerty' } }

    let(:params) { { session: session_params } }

    let(:session) { Session.new }

    before { expect(Session).to receive(:new).with(permit! session_params).and_return(session) }

    before { expect(session).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end

  describe '#destroy' do
    let(:session) { Session.new }

    before { expect(subject).to receive(:authenticate) }

    before { expect(subject).to receive(:resource).and_return(session) }

    before { expect(session).to receive(:destroy!) }

    before { process :destroy, method: :delete, format: :json }

    it { should respond_with :no_content }
  end
end
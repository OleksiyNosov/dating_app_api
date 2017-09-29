require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    before { sign_in }

    before { process :index, method: :get, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '5' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#create' do
    let(:event_params) { {
      place_id: '3', title: 'Party', description: 'Blackout 1 love',
      kind: 'public_event', start_time: "2017-09-29 23:10:20 +0300" 
    } }

    let(:params) { { event: event_params } }

    let(:user) { stub_model User, id: '2' }

    let(:merged_event_params) { event_params.merge(user_id: user.id) }

    let(:event) { stub_model Event }

    before { sign_in user }

    before { expect(Event).to receive(:new).with(permit! merged_event_params).and_return event }

    before { expect(subject).to receive(:add_new_invites) }

    before { expect(event).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end
end
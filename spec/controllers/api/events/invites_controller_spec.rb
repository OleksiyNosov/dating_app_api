require 'rails_helper'

RSpec.describe Api::Events::InvitesController, type: :controller do
  it { should be_an Api::InvitesController }

  describe '#index' do
    let(:params) { { event_id: '5' } }

    before { sign_in }

    before { process :index, method: :get, params: params, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    let(:params) { { event_id: '5', id: '7' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#create' do
    let(:params) { { event_id: '5' } }

    let(:invite_params) { { user_id: '2' } }

    let(:invites) { double }

    before { sign_in }

    before { expect(subject).to receive(:collection).and_return(invites) }

    before { expect(invites).to receive(:build).with(permit! invite_params).and_return(invite) }

    before { process :create, method: :post, params: params, format: :json }

    xit { should render_template :create }
  end

  describe '#parent' do
    let(:parent) { stub_model Event }

    before do
      expect(subject).to receive(:params) do
        double.tap { |a| expect(a).to receive(:[]).with(:event_id).and_return('5') }
      end
    end

    before { expect(Event).to receive(:find).with('5').and_return(parent) }

    its(:parent) { should eq parent }
  end
end
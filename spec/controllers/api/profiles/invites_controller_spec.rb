require 'rails_helper'

RSpec.describe Api::Profiles::InvitesController, type: :controller do
  it { should be_an Api::InvitesController }

  describe '#index' do
    before { sign_in }

    before { process :index, method: :get, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '7' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#update' do
    let(:invite_params) { { respond: :attend } }

    let(:params) { { invite: invite_params, id: '7' } } 

    let(:invites) { double }

    let(:invite) { stub_model Invite }

    let(:user) { stub_model User }

    before { sign_in }

    before { expect(subject).to receive(:collection).and_return(invites) }

    before { expect(invites).to receive(:find).with('7').and_return(invite) }

    before { expect(invite).to receive(:update!) }

    before { process :update, method: :patch, params: params, format: :json }

    it { should render_template :update }
  end  

  describe '#parent' do
    let(:parent) { stub_model User }

    before { expect(subject).to receive(:current_user).and_return(parent) }

    its(:parent) { should eq parent }
  end
end
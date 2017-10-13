require 'rails_helper'

RSpec.describe Api::Profiles::InvitesController, type: :controller do
  it { is_expected.to be_an Api::InvitesController }

  describe '#index' do
    before { sign_in }

    before { process :index, method: :get, format: :json }

    it { is_expected.to render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '7' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { is_expected.to render_template :show }
  end

  describe '#update' do
    let(:invite_params) { { respond: 'attend' } }

    let(:params) { { invite: invite_params, id: '7' } }

    let(:invite) { stub_model Invite }

    before { sign_in }

    before do
      #
      # -> collection.find
      #
      expect(subject).to receive(:collection) do
        double.tap { |a| expect(a).to receive(:find).with('7').and_return invite }
      end
    end

    before { expect(invite).to receive(:update!).with(permit! invite_params).and_return invite }

    before { process :update, method: :patch, params: params, format: :json }

    it { is_expected.to render_template :update }
  end

  describe '#parent' do
    let(:parent) { stub_model User }

    before { expect(subject).to receive(:current_user).and_return(parent) }

    its(:parent) { is_expected.to eq parent }
  end
end

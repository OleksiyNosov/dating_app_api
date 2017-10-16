require 'rails_helper'

RSpec.describe Api::Events::InvitesController, type: :controller do
  it { is_expected.to be_an Api::InvitesController }

  describe '#index' do
    let(:params) { { event_id: '5' } }

    before { sign_in }

    before { process :index, method: :get, params: params, format: :json }

    it { is_expected.to render_template :index }
  end

  describe '#show' do
    let(:params) { { event_id: '5', id: '7' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { is_expected.to render_template :show }
  end

  describe '#create' do
    let(:invite_params) { { user_id: '2' } }

    let(:params) { { invite: invite_params, event_id: '5' } }

    let(:invite) { stub_model Invite }

    before { sign_in }

    before do
      #
      # -> parent.invites.build
      #
      expect(subject).to receive(:parent) do
        double.tap do |a|
          expect(a).to receive(:invites) do
            double.tap { |b| expect(b).to receive(:build).with(permit! invite_params).and_return invite }
          end
        end
      end
    end

    before { expect(invite).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { is_expected.to render_template :create }
  end

  describe '#parent' do
    let(:parent) { stub_model Event }

    before do
      expect(subject).to receive(:params) do
        double.tap { |a| expect(a).to receive(:[]).with(:event_id).and_return('5') }
      end
    end

    before { expect(Event).to receive(:find).with('5').and_return(parent) }

    its(:parent) { is_expected.to eq parent }
  end
end

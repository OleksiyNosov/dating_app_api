require 'rails_helper'

RSpec.describe InviteDecorator do
  let(:invite) { stub_model Invite, id: 7, user_id: 2, event_id: 5, respond: 'attend' }

  describe '#as_json' do
    context 'with_user' do
      subject { invite.decorate context: { with_user: true } }

      let(:user) { stub_model User }

      before { expect(subject).to receive(:user).and_return user }

      its(:'as_json.symbolize_keys') do
        is_expected.to eq \
        id: 7,
        respond: 'attend',
        user: user
      end
    end

    context 'with_event' do
      subject { invite.decorate context: { with_event: true } }

      let(:event) { stub_model Event }

      before { expect(subject).to receive(:event).and_return event }

      its(:'as_json.symbolize_keys') do
        is_expected.to eq \
        id: 7,
        respond: 'attend',
        event: event
      end
    end
  end
end
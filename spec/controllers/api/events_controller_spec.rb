require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  it { is_expected.to be_an ApplicationController }

  describe '#index' do
    before { sign_in }

    before { process :index, method: :get, format: :json }

    it { is_expected.to render_template :index }
  end

  describe '#show' do
    let(:params) { { id: '5' } }

    before { sign_in }

    before { process :show, method: :get, params: params, format: :json }

    it { is_expected.to render_template :show }
  end

  describe '#create' do
    let(:invites) { ['15', '20'] }

    let(:event_params) { {
      place_id: '3', title: 'Party', description: 'Blackout 1 love',
      kind: 'public_event', start_time: "2017-09-29 23:10:20 +0300",
      invites: invites 
    } }

    let(:params) { { event: event_params } }

    let(:user) { stub_model User, id: '2' }

    let(:event) { stub_model Event }

    before { sign_in user }

    before { expect(subject).to receive(:resource_params).and_return event_params }

    before do
      #
      # => params[:event][:invites]
      #
      expect(subject).to receive(:params) do
        double.tap do |a| 
          expect(a).to receive(:[]).with(:event) do
            double.tap { |b| expect(b).to receive(:[]).with(:invites).and_return invites }
          end
        end
      end
    end

    before do
      #
      # => EventService.new().build_event
      #
      expect(EventService).to receive(:new).with(event_params, user, invites) do
        double.tap { |a| expect(a).to receive(:build_event).and_return event }
      end
    end

    before { expect(event).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { is_expected.to render_template :create }
  end

  describe '#collection' do
    let(:user) { stub_model User }

    let(:params) { {
      place_id: '3', title: 'Party', description: 'Blackout 1 love',
      kind: 'public_event', start_time: "2017-09-29 23:10:20 +0300",
      current_user: user 
    } }

    before { sign_in user }

    before { expect(subject).to receive(:params).and_return params }

    before do
      #
      # -> EventSearcher.search
      #
      expect(EventSearcher).to receive(:new).with(params) do
        double.tap { |a| expect(a).to receive(:search).and_return :collection }
      end
    end

    its(:collection) { should eq :collection }
  end
end
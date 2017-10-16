require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#authenticate' do
    before { expect(subject).to receive(:authenticate_or_request_with_http_token).and_return :result }

    its(:authenticate) { is_expected.to eq :result }
  end
end

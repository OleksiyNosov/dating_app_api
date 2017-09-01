require 'rails_helper'

RSpec.describe AuthTokenDecorator do
  let(:auth_token) { stub_model AuthToken, value: 'XXXX-YYYY-ZZZZ' }

  subject { auth_token.decorate }

  describe '#as_json' do
    its('as_json.symbolize_keys') { should eq value: 'XXXX-YYYY-ZZZZ' }
  end
end
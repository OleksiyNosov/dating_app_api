require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) do 
    stub_model User,
    id: 2,
    email: 'test@test.com',
    first_name: 'John',
    last_name: 'Smith',
    birth_day: Time.zone.new(1992, 1, 1)
  end
end
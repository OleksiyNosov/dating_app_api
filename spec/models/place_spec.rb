require 'rails_helper'

RSpec.describe Place, type: :model do
  it { should be_an ApplicationRecord }

  it { should have_many(:place_users) }

  it { should have_many(:users).through(:place_users) }
end

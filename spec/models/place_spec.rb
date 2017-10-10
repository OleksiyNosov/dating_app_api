require 'rails_helper'

RSpec.describe Place, type: :model do
  it { is_expected.to be_an ApplicationRecord }

  it { is_expected.to have_many(:place_users) }

  it { is_expected.to have_many(:users).through(:place_users) }
end

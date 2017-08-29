require 'rails_helper'

RSpec.describe PlaceUser, type: :model do
  it { should be_an ApplicationRecord }

  it { should belong_to(:user) }

  it { should belong_to(:place) }

  # it { should validate_uniqueness_of(:user_id).scoped_to(:place_id) }

  it { should validate_inclusion_of(:rating).in_range(1..5) }
end

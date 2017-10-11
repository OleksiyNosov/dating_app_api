require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to be_an ApplicationRecord }

  it { is_expected.to belong_to :place }

  it { is_expected.to belong_to :user }

  it { is_expected.to have_many :invites }

  it { is_expected.to validate_presence_of :place }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_presence_of :title }

  it { is_expected.to define_enum_for(:kind).with(%i[public_event private_event friends_only]) }
end

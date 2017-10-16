require 'rails_helper'

RSpec.describe Invite, type: :model do
  it { is_expected.to be_an ApplicationRecord }

  it { is_expected.to belong_to :event }

  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :event }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to define_enum_for(:respond).with(%i[no_respond attend not_attend]) }
end

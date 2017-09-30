require 'rails_helper'

RSpec.describe Invite, type: :model do
  it { should be_an ApplicationRecord }

  it { should belong_to :event }

  it { should belong_to :user }

  it { should validate_presence_of :event }

  it { should validate_presence_of :user }

  it { should define_enum_for(:respond).with([:no_respond, :attend, :not_attend]) }
end

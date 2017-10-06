require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it { is_expected.to be_an ActiveJob::Base }
end
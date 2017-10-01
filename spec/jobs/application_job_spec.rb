require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it { should be_an ActiveJob::Base }
end
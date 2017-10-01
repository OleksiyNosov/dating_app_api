require 'rails_helper'

RSpec.describe EventSearcher do
  subject { EventSearcher.new }

  describe '#initialize_results' do
    before { expect(Event).to receive(:all).and_return :all }

    its(:initialize_results) { should eq :all }
  end
end
require 'rails_helper'

RSpec.describe ApplicationSearcher do
  let(:searcher) { ApplicationSearcher.new }

  subject { searcher }

  describe '#initialize' do
    it { expect { ApplicationSearcher.new }.to_not raise_error }
  end

  describe '#search' do
    before { expect(subject).to receive(:initialize_results) }

    let(:params) { double }

    let(:results) { double }

    context 'regular attribute' do
      before { expect(params).to receive(:each) }
    end

    context 'current_user' do
      before { expect(params).to receive(:each) }

      xit { expect { searcher.search }.to_not raise_error }
    end
  end
end
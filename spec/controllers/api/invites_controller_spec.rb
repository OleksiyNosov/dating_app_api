require 'rails_helper'

RSpec.describe Api::InvitesController, type: :controller do
  it { should be_an ApplicationController }

  describe '#collection' do
    before do
      #
      # -> parent.invites
      # 
      expect(subject).to receive(:parent) do
        double.tap { |a| expect(a).to receive(:invites).and_return(:collection) }
      end       
    end

    its(:collection) { should eq :collection }
  end
end
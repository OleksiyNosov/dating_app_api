require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#full_name' do
    let(:first_name) { 'John' }

    let(:last_name) { 'Smith' }

    before do 
      expect(subject).to receive(:object) do
        double.tap { |a| expect(a).to receive(:first_name).and_return(first_name) }
      end 
    end

    before { expect(subject).to receive(:last_name).and_return(last_name) }

    let(:result) { "#{ first_name } #{ last_name }" }

    xit(:full_name) { should eq result }
  end

  describe '#age' do

  end

  describe '#coords' do
    let(:lat) { 28.3 }

    let(:lng) { 48.5 }

    let(:result) { { lat: lat, lng: lng } }

    xit(:coords) { should eq result }
  end

  describe '#avatar' do
    xit { }
  end

  describe '#collection' do
    let(:context) { { context: { user_user_ratings: true } } }

    let(:place_users) { double }

    let(:collection) { double }

    before { expect(subject).to receive(:place_users).and_return(place_users) }

    before do 
      expect(PlaceUserDecorator).to receive(:decorate_collection).with(place_users, context).and_return(collection) 
    end

    xit(:collection) { should eq collection }
  end

  describe '#as_json' do
    let(:user) do 
      stub_model User,
      id: 2,
      email: 'test@test.com',
      first_name: 'John',
      last_name: 'Smith',
      gender: 'male',
      birthday: Time.new(1992, 1, 1)
    end

    context do
      subject { user.decorate }

      let(:full_name) { 'John Smith' }
      
      let(:avatar) { :avatar }

      before { expect(subject).to receive(:full_name).and_return(full_name) }

      before { expect(subject).to receive(:avatar).and_return(avatar) }

      its('as_json.symbolize_keys') do
        should eq \
        id: 2,
        gender: 'male',
        full_name: full_name,
        avatar: avatar
      end
    end

    context 'full' do
      subject { user.decorate(context: { full: true }) }

      let(:full_name) { 'John Smith' }

      let(:avatar) { :avatar }

      let(:coords) { double }

      before { expect(subject).to receive(:full_name).and_return(full_name) }

      before { expect(subject).to receive(:avatar).and_return(avatar) }

      before { expect(subject).to receive(:coords).and_return(coords) }

      its('as_json.symbolize_keys') do
        should eq \
        id: 2,
        gender: 'male',
        email: 'test@test.com',
        birthday: Time.new(1992, 1, 1),
        full_name: full_name,
        avatar: avatar,
        coords: coords
      end
    end

    context 'short' do
      subject { user.decorate(context: { short: true }) }

      let(:full_name) { 'John Smith' }

      let(:avatar) { :avatar }

      let(:age) { 18 }

      before { expect(subject).to receive(:full_name).and_return(full_name) }

      before { expect(subject).to receive(:avatar).and_return(avatar) }

      before { expect(subject).to receive(:age).and_return(age) }

      its('as_json.symbolize_keys') do
        should eq \
        id: 2,
        gender: 'male',
        full_name: full_name,
        avatar: avatar,
        age: age
      end
    end

    context 'user_user_ratings' do
      subject { user.decorate(context: { user_user_ratings: true }) }

      let(:collection) { [] }

      let(:result) { { collection: collection } }

      before { expect(subject).to receive(:collection).and_return(collection) }

      its('as_json.symbolize_keys') { should eq result }
    end
  end
end
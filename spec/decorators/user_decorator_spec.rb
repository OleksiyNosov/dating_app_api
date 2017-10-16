require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) { stub_model User, first_name: 'John', last_name: 'Smith', lat: 28.3, lng: 48.5 }

  subject { user.decorate }

  describe '#full_name' do
    its(:full_name) { is_expected.to eq 'John Smith' }
  end

  describe '#coords' do
    its(:coords) { is_expected.to eq lat: 28.3, lng: 48.5 }
  end

  describe '#age' do
  end

  describe '#avatar' do
    before do
      #
      # => object.avatar.url
      #
      expect(subject).to receive(:object) do
        double.tap do |a|
          expect(a).to receive(:avatar) do
            double.tap { |b| expect(b).to receive(:url).and_return 'original_url' }
          end
        end
      end
    end

    before do
      #
      # => object.avatar.url
      #
      expect(subject).to receive(:object) do
        double.tap do |a|
          expect(a).to receive(:avatar) do
            double.tap { |b| expect(b).to receive(:url).with(:thumb).and_return 'thumb_url' }
          end
        end
      end
    end

    its(:avatar) { is_expected.to eq original_url: 'original_url', thumb_url: 'thumb_url' }
  end

  describe '#collection' do
    let(:context) { { context: { user_user_ratings: true } } }

    let(:place_users) { double }

    before { expect(subject).to receive(:place_users).and_return place_users }

    before do
      #
      # => PlaceUserDecorator.decorate_collection
      #
      expect(PlaceUserDecorator).to receive(:decorate_collection).with(place_users, context).and_return :collection
    end

    its(:collection) { is_expected.to eq :collection }
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
        is_expected.to eq \
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
        is_expected.to eq \
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
        is_expected.to eq \
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

      its('as_json.symbolize_keys') { is_expected.to eq result }
    end
  end
end

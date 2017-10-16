require 'rails_helper'

RSpec.describe EventDecorator do
  let(:event) do
    stub_model Event,
               id: 5,
               user_id: 2,
               place_id: 3,
               title: 'Party',
               description: 'Blackout 1 love',
               kind: 'public_event',
               start_time: Time.new(2017, 9, 30, 23, 36)
  end

  subject { event.decorate }

  describe '#date' do
    before do
      #
      # => start_time.strftime
      #
      expect(subject).to receive(:start_time) do
        double.tap { |a| expect(a).to receive(:strftime).with('%F').and_return '2017-9-30' }
      end
    end

    its(:date) { is_expected.to eq '2017-9-30' }
  end

  describe '#time' do
    before do
      #
      # => start_time.strftime
      #
      expect(subject).to receive(:start_time) do
        double.tap { |a| expect(a).to receive(:strftime).with('%H:%M').and_return '23:36' }
      end
    end

    its(:time) { is_expected.to eq '23:36' }
  end

  describe '#author' do
    let(:user) { stub_model User }

    before { expect(subject).to receive(:user).and_return user }

    its(:author) { is_expected.to eq user }
  end

  describe '#people_attend_count' do
    before do
      #
      # => object.people_attend.count
      #
      expect(subject).to receive(:object) do
        double.tap do |a|
          expect(a).to receive(:people_attend) do
            double.tap { |b| expect(b).to receive(:count).and_return 4 }
          end
        end
      end
    end

    its(:people_attend_count) { is_expected.to eq 4 }
  end

  describe '#people_attend' do
    before do
      #
      # => object.people_attend.decorate
      #
      expect(subject).to receive(:object) do
        double.tap do |a|
          expect(a).to receive(:people_attend) do
            double.tap { |b| expect(b).to receive(:decorate).with(context: { short: true }).and_return :people_attend }
          end
        end
      end
    end

    its(:people_attend) { is_expected.to eq :people_attend }
  end

  describe '#invites' do
    before do
      #
      # => object.invites.decorate
      #
      expect(subject).to receive(:object) do
        double.tap do |a|
          expect(a).to receive(:invites) do
            double.tap { |b| expect(b).to receive(:decorate).with(context: { with_user: true }).and_return :invites }
          end
        end
      end
    end

    its(:invites) { is_expected.to eq :invites }
  end

  describe '#as_json' do
    context 'short' do
      subject { event.decorate context: { short: true } }

      let(:place) { stub_model Place }

      before { expect(subject).to receive(:place).and_return place }

      before { expect(subject).to receive(:date).and_return '2017-9-30' }

      before { expect(subject).to receive(:time).and_return '23:36' }

      its(:'as_json.symbolize_keys') do
        is_expected.to eq \
          id: 5,
          kind: 'public_event',
          title: 'Party',
          description: 'Blackout 1 love',
          place: place,
          date: '2017-9-30',
          time: '23:36'
      end
    end

    context 'full' do
      subject { event.decorate context: { full: true } }

      let(:place) { stub_model Place }

      let(:author) { stub_model User }

      before { expect(subject).to receive(:place).and_return place }

      before { expect(subject).to receive(:author).and_return author }

      before { expect(subject).to receive(:date).and_return '2017-9-30' }

      before { expect(subject).to receive(:time).and_return '23:36' }

      before { expect(subject).to receive(:people_attend_count).and_return 4 }

      before { expect(subject).to receive(:people_attend).and_return :people_attend }

      before { expect(subject).to receive(:invites).and_return :invites }

      its(:'as_json.symbolize_keys') do
        is_expected.to eq \
          id: 5,
          kind: 'public_event',
          title: 'Party',
          description: 'Blackout 1 love',
          place: place,
          date: '2017-9-30',
          time: '23:36',
          author: author,
          people_attend_count: 4,
          people_attend: :people_attend,
          invites: :invites
      end
    end
  end
end

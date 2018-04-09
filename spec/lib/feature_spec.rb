require 'spec_helper'
require 'fakeredis/rspec'

describe Rcurtain do
  subject(:rcurtain) { Rcurtain.feature }
  let(:curtain) { Rcurtain.instance }
  let(:users) { ['MPA-000000000000', 'MPA-111111111111'] }

  describe '#add' do
    before do
      subject.add('feature', users)
    end

    context 'when adding single user' do
      let(:users) { ['MPA-00000000000'] }

      it 'should be enabled to added user' do
        expect(curtain.opened?('feature', users)).to be true
      end
    end

    context 'when adding multiple users' do
      it 'should be enabled to added users' do
        expect(curtain.opened?('feature', users)).to be true
      end
    end
  end

  describe '#remove' do
    before do
      subject.add('feature', users)
      subject.remove('feature', users)
    end

    context 'when removing single user' do
      let(:users) { ['MPA-00000000000'] }

      it 'should be disabled to removed user' do
        expect(curtain.opened?('feature', users)).to be false
      end
    end

    context 'when removing multiple users' do
      it 'should be disabled to removed users' do
        expect(curtain.opened?('feature', users)).to be false
      end
    end
  end

  describe '#update' do
    before do
      subject.update('feature', percentage)
    end

    context 'when updating percentage to 100 percent' do
      let(:percentage) { 100 }

      it 'should be enabled to all users' do
        expect(curtain.opened?('feature')).to be true
      end
    end

    context 'when updating percentage to 0 percent' do
      let(:percentage) { 0 }

      it 'should be disabled to all users' do
        expect(curtain.opened?('feature')).to be false
      end
    end
  end

  describe '#array' do
    context 'when there are users enabled' do
      before do
        subject.add('feature', users)
      end

      it 'should return list with all added users' do
        expect(subject.array('feature').sort).to eq(users.sort)
      end
    end

    context 'when there are no users enabled' do
      it 'should return empty user list' do
        expect(subject.array('feature')).to be_empty
      end
    end
  end

  describe '#number' do
    context 'when percentage is any value' do
      let(:rand) { Random.new.rand(1..100) }

      before do
        subject.update('feature', rand)
      end

      it 'should return correct percentage value' do
        expect(subject.number('feature')).to eq(rand)
      end
    end
  end
end

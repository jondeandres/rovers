require 'spec_helper'
require 'plateau'

describe Plateau do
  subject { Plateau.new(%w[5 10]) }

  describe '#can_move_to?' do
    shared_examples 'cannot move' do
      it 'cannot move to that coordinates' do
        expect(subject.can_move_to?(coordinates)).to be(false)
      end
    end

    context 'with x minor than 0' do
      let(:coordinates) { [-2, 2] }
      it_should_behave_like('cannot move')
    end

    context 'with y minor than 0' do
      let(:coordinates) { [2, -1] }
      it_should_behave_like('cannot move')
    end

    context 'with x greather than plateau' do
      let(:coordinates) { [6, 2] }
      it_should_behave_like('cannot move')
    end

    context 'with y greater than plateau' do
      let(:coordinates) { [2, 11] }
      it_should_behave_like('cannot move')
    end

    context 'with x and y in range' do
      let(:coordinates) { [2, 3] }

      it 'moves to that coordinates' do
        expect(subject.can_move_to?(coordinates)).to be(true)
      end
    end
  end
end

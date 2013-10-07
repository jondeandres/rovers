require 'spec_helper'

require 'rover'
require 'plateau'

describe Rover do
  let(:plateau) { Plateau.new(['5', '10']) }

  describe '#spin_left' do
    context 'actually in North' do
      let(:rover) { Rover.new(plateau, ['0', '0', 'N']) }
      subject { rover }
      before { subject.spin_left }
      its(:orientation_index) { should eql(3) }
    end

    context 'actually in South' do
      let(:rover) { Rover.new(plateau, ['0', '0', 'S']) }
      subject { rover }
      before { subject.spin_left }
      its(:orientation_index) { should eql(1) }
    end
  end

  describe '#spin_right' do
    context 'actually in North' do
      let(:rover) { Rover.new(plateau, ['0', '0', 'N']) }
      subject { rover }
      before { subject.spin_right }
      its(:orientation_index) { should eql(1) }
    end

    context 'actually in West' do
      let(:rover) { Rover.new(plateau, ['0', '0', 'W']) }
      subject { rover }
      before { subject.spin_right }
      its(:orientation_index) { should eql(0) }
    end
  end

  describe '#move_forward' do
    context 'when can move to north' do
      let(:rover) { Rover.new(plateau, ['2', '2', 'N']) }
      before do
        rover.stub(:can_move_to?).and_return(true)
        rover.stub(:coordinates_to_n).and_return(['2', '1'])
      end

      it 'moves to the correct coordinates' do
        rover.move_forward
        rover.x.should eql('2')
        rover.y.should eql('1')
      end
    end

    context 'when cannot move to north' do
      let(:rover) { Rover.new(plateau, ['2', '0', 'N']) }
      before do
        rover.stub(:can_move_to?).and_return(false)
        rover.stub(:coordinates_to_n).and_return([2, -1])
      end

      it 'doesnt move from the actual coordinates' do
        rover.move_forward
        rover.x.should eql(2)
        rover.y.should eql(0)
      end
    end
  end

  describe '#can_move_to?' do
    let(:rover) { Rover.new(plateau, ['2', '2', 'N']) }

    shared_examples 'cannot move' do
      it 'cannot move to that coordinates' do
        rover.can_move_to?(coordinates).should be_false
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
        rover.can_move_to?(coordinates).should be_true
      end
    end
  end
end

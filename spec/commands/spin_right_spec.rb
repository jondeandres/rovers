require 'spec_helper'
require 'commands/spin_right'
require 'rover'
require 'plateau'

describe Commands::SpinRight do
  let(:plateau) { Plateau.new(['5', '10']) }
  let(:rover) { Rover.new(plateau, position) }

  describe '#call' do
    context 'with a orientation_index 1' do
      let(:position) { ['0', '0', 'N'] }

      it 'increments the orientation index' do
        expect do
          subject.call(rover)
        end.to change(rover, :orientation_index).by(1)
      end
    end

    context 'with the maximum orientation index' do
      let(:position) { ['0', '0', 'W'] }

      it 'sets the orientation index to 0' do
        expect do
          subject.call(rover)
        end.to change(rover, :orientation_index).from(3).to(0)
      end
    end
  end
end

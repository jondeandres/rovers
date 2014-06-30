require 'spec_helper'
require 'commands/move_forward'
require 'plateau'
require 'rover'

describe Commands::MoveForward do
  let(:plateau) { Plateau.new(['5', '10']) }
  let(:rover) { Rover.new(plateau, position) }

  describe '#call' do
    context 'if the rover can move forward' do
      let(:position) { ['2', '2', 'N'] }

      it 'changes rover Y coordinate to 1' do
        expect { subject.call(rover) }.to change(rover, :y).by(1)
      end

      it 'doesnt change X coordinate' do
        expect { subject.call(rover) }.to_not change(rover, :x)
      end
    end

    context 'if the rover cannot move forward' do
      let(:position) { ['2', '10', 'N'] }

      it 'doesnt change Y coordinate' do
        expect { subject.call(rover) }.to_not change(rover, :y)
      end

      it 'doesnt change X coordinate' do
        expect { subject.call(rover) }.to_not change(rover, :x)
      end
    end
  end
end

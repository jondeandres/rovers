require 'spec_helper'
require 'commands/spin_left'
require 'rover'
require 'plateau'

describe Commands::SpinLeft do
  let(:plateau) { Plateau.new(['5', '10']) }
  let(:rover) { Rover.new(plateau, position) }

  describe '#call' do
    context 'with orientation_index 0' do
      let(:position) { ['0', '0', 'N'] }

      it 'sets the max orientation_index' do
        expect do
          subject.call(rover)
        end.to change(rover, :orientation_index).from(0).to(3)
      end
    end

    context 'with orientation index in the max value' do
      let(:position) { ['0', '0', 'S'] }

      it 'sets decrements the orientation index' do
        expect do
          subject.call(rover)
        end.to change(rover, :orientation_index).by(-1)
      end
    end
  end
end

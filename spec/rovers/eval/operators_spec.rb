require 'spec_helper'
require 'rovers/eval/operators'

describe Rovers::Eval::Operators do
  let(:plateau) { Plateau.new(['5 5']) }

  describe '#create_plateau' do
    it 'returns a Plateau instance' do
      plateau = subject.create_plateau([['5 5']])
      expect(plateau).to be_kind_of(Plateau)
    end
  end

  describe '#create_plateau' do
    it 'returns a Plateau instance' do
      rover = subject.create_rover([['1 1 N']], plateau)
      expect(rover).to be_kind_of(Rover)
    end
  end

  describe '#movement' do
    let(:rover) { Rover.new(plateau, ['1 1 N']) }

    context 'with existing command class' do
      let(:args) { ['L'] }

      it 'calls the correct command' do
        expect(Commands::SpinLeft).to receive(:call).with(rover)

        subject.movement(args, rover)
      end
    end

    context 'with unknown command' do
      let(:args) { ['C'] }

      it 'raise an error' do
        expect { subject.command(args, rover) }.to raise_error
      end
    end
  end
end

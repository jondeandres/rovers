require 'spec_helper'
require 'app'

describe App do
  let(:file_name) { 'the-path-to-the-filename' }
  let(:file) { double('file', read: data)}
      let(:data) do
      <<-END
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
      END
    end

  subject { App.new(file_name) }

  before do
    allow(File).to receive(:open).
      with(file_name, 'r').
      and_return(file)
  end

  describe '.new' do
    it 'splits the lines and saves them as instance variable' do
      expect(subject.data).to be_eql([
          '5 5', '1 2 N',
          'LMLMLMLMM', '3 3 E',
          'MMRMMRMRRM'
        ])
    end
  end

  describe '#parse_coordinates' do
    let(:line) { "4 10" }

    it 'parses properly the plateau coordinates' do
      expect(subject.parse_coordinates(line)).to be_eql(['4', '10'])
    end
  end

  describe '#parse_position' do
    let(:line) { "1 5 N" }

    it 'parses properly the position' do
      expect(subject.parse_position(line)).to be_eql(['1', '5', 'N'])
    end
  end

  describe '#command_for_char' do
    shared_examples('command from char') do
      it 'returns the proper command class' do
        expect(subject.command_for_char(char)).to be_eql(command_class)
      end
    end

    context 'with L' do
      let(:char) { 'L' }
      let(:command_class) { Commands::SpinLeft }
      it_should_behave_like 'command from char'
    end

    context 'with R' do
      let(:char) { 'R' }
      let(:command_class) { Commands::SpinRight }
      it_should_behave_like 'command from char'
    end

    context 'with M' do
      let(:char) { 'M' }
      let(:command_class) { Commands::MoveForward }
      it_should_behave_like 'command from char'
    end
  end

  describe '#run' do
    before do
      expect(Plateau).to receive(:new).with(["5", "5"])
      expect(subject).to receive(:move_rover).
        with(a_kind_of(Rover), "LMLMLMLMM").once
      expect(subject).to receive(:move_rover).
        with(a_kind_of(Rover), "MMRMMRMRRM").once
    end

    it 'moves the rovers' do
      subject.run
    end
  end

  describe '#move_rover' do
    let(:plateau) { Plateau.new(["5", "5"]) }
    let(:position) { ["1", "2", "N"] }
    let(:rover) { Rover.new(plateau, position) }

    context 'when the method exists' do
      let(:instructions) { "LRM" }

      before do
        expect(Commands::SpinLeft).to receive(:call).once
        expect(Commands::SpinRight).to receive(:call).once
        expect(Commands::MoveForward).to receive(:call).once
      end

      it { subject.move_rover(rover, instructions) }
    end
  end
end

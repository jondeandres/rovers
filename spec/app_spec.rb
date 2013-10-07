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
  let(:instance) { App.new(file_name) }

  subject { instance }

  before do
    File.should_receive(:open).
      with(file_name, 'r').
      and_return(file)
  end

  describe '.new' do
    it 'splits the lines and saves them as instance variable' do
      subject.data.should eql([
          '5 5', '1 2 N',
          'LMLMLMLMM', '3 3 E',
          'MMRMMRMRRM'
        ])
    end
  end

  describe '#parse_coordinates' do
    let(:line) { "4 10" }

    it 'parses properly the plateau coordinates' do
      subject.parse_coordinates(line).should eql(['4', '10'])
    end
  end

  describe '#parse_position' do
    let(:line) { "1 5 N" }

    it 'parses properly the position' do
      subject.parse_position(line).should eql(['1', '5', 'N'])
    end
  end

  describe '#method_from_char' do
    shared_examples('method from char') do
      it 'returns the proper mehod name' do
        instance.method_from_char(char).should eql(method_name)
      end
    end

    context 'with L' do
      let(:char) { 'L' }
      let(:method_name) { :spin_left }
      it_should_behave_like 'method from char'
    end

    context 'with R' do
      let(:char) { 'R' }
      let(:method_name) { :spin_right }
      it_should_behave_like 'method from char'
    end

    context 'with M' do
      let(:char) { 'M' }
      let(:method_name) { :move_forward }
      it_should_behave_like 'method from char'
    end
  end

  describe '#run' do
    before do
      Plateau.should_receive(:new).with(["5", "5"])
      instance.should_receive(:move_rover).
        with(a_kind_of(Rover), "LMLMLMLMM").once
      instance.should_receive(:move_rover).
        with(a_kind_of(Rover), "MMRMMRMRRM").once
    end

    it 'moves the rovers' do
      instance.run
    end
  end

  describe '#move_rover' do
    let(:plateau) { Plateau.new(["5", "5"]) }
    let(:position) { ["1", "2", "N"] }
    let(:rover) { Rover.new(plateau, position) }

    context 'when the method exists' do
      let(:instructions) { "LRM" }

      before do
        rover.should_receive(:send).exactly(3)
      end

      it { subject.move_rover(rover, instructions) }
    end
  end
end
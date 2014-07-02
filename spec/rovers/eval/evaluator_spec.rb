require 'spec_helper'
require 'rovers/eval/evaluator'
require 'rovers/node_factory'

describe Rovers::Eval::Evaluator do
  let(:factory) { Rovers::NodeFactory.new }
  let(:tree) do
    factory.plateau_node('5 5',
                         [factory.rover_node('1 1'),
                          factory.rover_node('2 2')])
  end

  subject { described_class.new(tree) }

  describe '#eval' do
    let(:operators) { subject.send(:operators) }
    it 'calls the operator methods' do
      expect(operators).to receive(:send).exactly(3)

      subject.eval
    end
  end
end

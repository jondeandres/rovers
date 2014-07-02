require 'spec_helper'
require 'rovers/parser'

describe Rovers::Parser do
  let(:input) { File.read(File.expand_path('../../../data/input', __FILE__)) }

  subject { described_class.new(input) }

  describe 'parse!' do
    it 'generates the correct nodes tree' do
      root = subject.parse!
      expect(root).to be_kind_of(Rovers::NodeFactory::Node)
      expect(root.name).to be_eql('create_plateau')

      children = root.children
      expect(children.count).to be(2)

      rover1 = children[0]
      expect(rover1.name).to be_eql('create_rover')
      expect(rover1.children.first.name).to be_eql('command')
      expect(rover1.children.last.args).to be_eql(['S'])

      rover2 = children[1]
      expect(rover2.name).to be_eql('create_rover')
      expect(rover1.children.first.name).to be_eql('command')
      expect(rover1.children.last.args).to be_eql(['S'])
    end
  end
end

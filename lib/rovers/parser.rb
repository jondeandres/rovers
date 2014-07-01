require 'rovers/node_factory'

module Rovers
  class Parser
    attr_reader :input, :factory

    def initialize(input)
      @input = input.split("\n")
      @factory = Rovers::NodeFactory.new
    end

    def parse!
      plateau_size = parse_plateau_size!(input)
      generate_tree(plateau_size, input)
    end

    private

    def parse_plateau_size!(input)
      input.shift
    end

    def generate_tree(plateau_size, input)
      factory.plateau_node(plateau_size, parse_rovers(input))
    end

    def parse_rovers(input)
      map_slices(input) do |position, commands|
        factory.rover_node(position, parse_rover_children(commands))
      end
    end

    def map_slices(input)
      input.enum_for(:each_slice, 2).map do |*args|
        yield(*args)
      end
    end

    def parse_rover_children(commands)
      command_children = commands.chars.reduce([]) do |children, command|
        children << factory.command_node(command)
      end

      command_children + default_rover_children
    end

    def default_rover_children
      [factory.command_node('S')]
    end
  end
end

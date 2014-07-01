module Rovers
  class Parser
    attr_reader :input

    class Node < Struct.new(:name, :args, :children); end

    def initialize(input)
      @input = input.split("\n")
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
      plateau_node(plateau_size, parse_rovers(input))
    end

    def parse_rovers(input)
      map_slices(input) do |position, commands|
        rover_node(position, parse_rover_children(commands))
      end
    end

    def map_slices(input)
      input.enum_for(:each_slice, 2).map do |*args|
        yield(*args)
      end
    end

    def parse_rover_children(commands)
      command_children = commands.chars.reduce([]) do |children, command|
        children << movement_node(command)
      end

      command_children + default_rover_children
    end

    def default_rover_children
      [show_position_node]
    end

    def plateau_node(size, children = [])
      Node.new('create_plateau', [size.split(' ')], children)
    end

    def rover_node(position, children = [])
      Node.new('create_rover', [position.split(' ')], children)
    end

    def movement_node(command)
      Node.new('movement', [command], [])
    end

    def show_position_node
      Node.new('show_position', [], [])
    end
  end
end

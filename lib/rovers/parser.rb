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
      reduce_slices(input) do |tree, (position, commands)|
        rover_children = [move_rover(commands), show_position]
        rover_node = create_rover(position, rover_children)
        plateau_node = create_plateau(plateau_size, [rover_node])

        tree << plateau_node
      end
    end

    def reduce_slices(input)
      input.enum_for(:each_slice, 2).reduce([]) do |*args|
        yield(*args)
      end
    end

    def create_plateau(size, children)
      Node.new('create_plateau', size.split(' '), children)
    end

    def create_rover(position, children)
      Node.new('create_rover', position.split(' '), children)
    end

    def move_rover(commands)
      Node.new('move_rover', commands.chars, [])
    end

    def show_position
      Node.new('show_position', [], [])
    end
  end
end

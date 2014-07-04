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
      command_children = reduce_commands(commands) do |children, (command, op, args)|
        children << parse_rover_command(op, args)
      end

      command_children + default_rover_children
    end

    def parse_rover_command(op, args)
      if op =~ movements_regex
        factory.movement_node(op)
      elsif op == 'X'
        factory.rocket_node(args)
      end
    end

    def reduce_commands(commands)
      commands.scan(rover_commands_regex).reduce([]) do |*args|
        yield(*args)
      end
    end

    def rover_commands_regex
       /(([A-Z])({.*}){0,1}){1}/
    end

    def movements_regex
      /L|M|R/
    end

    def default_rover_children
      [factory.position_node]
    end
  end
end

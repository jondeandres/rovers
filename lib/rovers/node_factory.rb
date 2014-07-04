module Rovers
  class NodeFactory
    class Node < Struct.new(:name, :args, :children); end

    def plateau_node(size, children = [])
      Node.new('create_plateau', [size.split(' ')], children)
    end

    def rover_node(position, children = [])
      Node.new('create_rover', [position.split(' ')], children)
    end

    def movement_node(command)
      Node.new('movement', [command], [])
    end

    def rocket_node(args)
      coords = args.scan(/\d+/)

      Node.new('launch_rocket', [coords], [])
    end

    def position_node
      Node.new('position', [], [])
    end
  end
end

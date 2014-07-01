module Rovers
  class NodeFactory
    class Node < Struct.new(:name, :args, :children); end

    def plateau_node(size, children = [])
      Node.new('create_plateau', [size.split(' ')], children)
    end

    def rover_node(position, children = [])
      Node.new('create_rover', [position.split(' ')], children)
    end

    def command_node(command)
      Node.new('command', [command], [])
    end
  end
end

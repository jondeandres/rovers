module Rovers
  module Eval
    class Evaluator
      attr_reader :root

      def initialize(root)
        @root = root
      end

      def eval
        eval_node(root, root.args)
      end

      private

      def eval_node(node, args = [], extra_arg = nil)
        result = operators.send(node.name, args, extra_arg)

        node.children.each { |child| eval_node(child, child.args, result) }
      end

      def operators
        @operators ||= Rovers::Eval::Operators.new
      end
    end
  end
end

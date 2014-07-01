module Rovers
  module Eval
    class Evaluator
      attr_reader :tree

      def initialize(tree)
        @tree = tree
      end

      def eval
        tree.each { |node| eval_node(node, node.args) }
      end

      private

      def eval_node(node, args = [], extra_arg = nil)
        result = operators.send(node.name, args, extra_arg)

        node.children.each {  |child| eval_node(child, child.args, result) }
      end

      def operators
        Rovers::Eval::Operators.new
      end
    end
  end
end

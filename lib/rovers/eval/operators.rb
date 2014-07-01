require 'plateau'
require 'rover'
require 'active_support/core_ext/string'

Dir[File.expand_path('../../../../app/commands/**/*.rb', __FILE__)].each{ |f| require(f) }

module Rovers
  module Eval
    class Operators
      INPUT_MAPPING = {
        'L' => :spin_left,
        'R' => :spin_right,
        'M' => :move_forward
      }

      def create_plateau(size, _ = nil)
        Plateau.new(size)
      end

      def create_rover(position, plateau)
        Rover.new(plateau, position)
      end

      def move_rover(commands, rover)
        commands.each do |char|
          klass = command_for_char(char)
          klass.call(rover)
        end
      end

      def show_position(_, rover)
        ::Commands::ShowPosition.call(rover)
      end

      private

      def command_for_char(char)
        Commands.const_get(INPUT_MAPPING[char].to_s.classify)
      rescue NameError
        raise "Cannot find command for #{char}."
      end
    end
  end
end

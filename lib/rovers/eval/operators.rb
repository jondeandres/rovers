require 'plateau'
require 'rover'
require 'active_support/core_ext/string'

Dir[File.expand_path('../../../../app/commands/**/*.rb', __FILE__)].each{ |f| require(f) }

module Rovers
  module Eval
    class Operators
      MOVEMENTS = {
        'L' => :spin_left,
        'R' => :spin_right,
        'M' => :move_forward
      }

      def create_plateau(args, _)
        Plateau.new(*args)
      end

      def create_rover(args, plateau)
        Rover.new(plateau, *args)
      end

      def movement(args, rover)
        klass = command_for_char(*args)
        klass.call(rover)
      end

      def show_position(args, rover)
        Commands::ShowPosition.call(rover)
      end

      private

      def command_for_char(char)
        Commands.const_get(MOVEMENTS[char].to_s.classify)
      rescue NameError
        raise "Cannot find command for #{char}."
      end
    end
  end
end

require 'rovers/command'

module Commands
  class MoveForward
    extend Rovers::Command

    def call(rover)
      coordinates_method = "coordinates_to_#{rover.orientation.downcase}".to_sym
      new_coordinates = send(coordinates_method, rover.x, rover.y)

      move(rover, new_coordinates)
    end

    private

    def move(rover, coordinates)
      plateau = rover.plateau

      if plateau.can_move_to?(coordinates)
        rover.x, rover.y = coordinates
      else
        puts "Not able to move to: x: #{coordinates}"
      end
    end

    def coordinates_to_n(x, y)
      [x, y + 1]
    end

    def coordinates_to_e(x, y)
      [x + 1, y]
    end

    def coordinates_to_s(x, y)
      [x, y - 1]
    end

    def coordinates_to_w(x, y)
      [x - 1, y]
    end
  end
end

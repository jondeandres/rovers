require 'rover'
require 'rovers/command'

module Commands
  class SpinRight
    extend Rovers::Command

    def call(rover)
      new_orientation_index = rover.orientation_index + 1

      if new_orientation_index > (Rover::ORIENTATIONS.length - 1)
        rover.orientation_index = 0
      else
        rover.orientation_index = new_orientation_index
      end
    end
  end
end

class Plateau
  attr_reader :x, :y

  # Instances a {Plateau} with its dimensions
  # @param [Integer] x the x coordinate
  # @param [Integer] y the y coordinate
  def initialize(coordinates)
    @x, @y = coordinates.map(&:to_i)
  end

  # Tests if it's possible to move to the received coordinates.
  # @param [Array] coordinates the new coordinates to test
  def can_move_to?(coordinates)
    new_x, new_y = coordinates

    coord_inside?(:x, new_x) && coord_inside?(:y, new_y)
  end

  private

  def coord_inside?(coord, value)
    value >= 0 && value <= send(coord)
  end
end

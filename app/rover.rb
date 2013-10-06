class Rover
  attr_reader :plateau, :x, :y, :orientation

  # Instances a {Rover} with a #{Plateau} and
  # the position.
  # @param [Plateau] plateau the plateau where the #{Rover}
  #   will move.
  # @param [Array] position an array with the x, y coordinates
  #   and orientation (N E S W).
  def initialize(plateau, position)
    @plateau = plateau
    @x, @y, @orientation = position
  end
end

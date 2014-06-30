class Rover
  ORIENTATIONS = %w{N E S W}

  attr_reader :plateau
  attr_accessor :x, :y, :orientation_index

  # Instances a {Rover} with a #{Plateau} and
  # the position.
  # @param [Plateau] plateau the plateau where the #{Rover}
  #   will move.
  # @param [Array] position an array with the x, y coordinates
  #   and orientation (N E S W).
  def initialize(plateau, position)
    @plateau = plateau
    x, y, orientation = position
    @x, @y = x.to_i, y.to_i
    @orientation_index = ORIENTATIONS.index(orientation)
  end

  def orientation
    ORIENTATIONS[orientation_index]
  end

  def show_position
    puts "#{x} #{y} #{orientation}"
  end
end

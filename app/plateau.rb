class Plateau
  attr_reader :x, :y

  # Instances a {Plateau} with its dimensions
  # @param [Integer] x the x coordinate
  # @param [Integer] y the y coordinate
  def initialize(coordinates)
    @x, @y = coordinates
  end
end

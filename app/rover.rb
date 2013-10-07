class Rover
  attr_reader :plateau
  attr_accessor :x, :y, :orientation_index

  ORIENTATIONS = %w{N E S W}

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

  # Spin the {Rover} 90 degrees to the left.
  def spin_left
    new_orientation_index = orientation_index - 1

    if new_orientation_index < 0
      self.orientation_index = ORIENTATIONS.length - 1
    else
      self.orientation_index = new_orientation_index
    end
  end

  # Spin the {Rover} 90 degrees to the right.
  def spin_right
    new_orientation_index = orientation_index + 1

    if new_orientation_index > (ORIENTATIONS.length - 1)
      self.orientation_index = 0
    else
      self.orientation_index = new_orientation_index
    end
  end

  # Moves the {Rover} to new coordinates. Depending on the actual
  # orientation the coordinates will change.
  def move_forward
    coordinates_method = "coordinates_to_#{orientation.downcase}".to_sym
    new_coordinates = send(coordinates_method)

    if can_move_to?(new_coordinates)
      self.x, self.y = new_coordinates
    else
      puts "Not able to move to: x: #{new_coordinates}"
    end
  end

  def coordinates_to_n
    [x, y + 1]
  end

  def coordinates_to_e
    [x + 1, y]
  end

  def coordinates_to_s
    [x, y - 1]
  end

  def coordinates_to_w
    [x - 1, y]
  end

  # Tests if it's possible to move to the received coordinates.
  # @param [Array] coordinates the new coordinates to test
  def can_move_to?(coordinates)
    new_x, new_y = coordinates

    coord_in_plateau?(:x, new_x) &&
      coord_in_plateau?(:y, new_y)
  end

  def coord_in_plateau?(coord, value)
    value >= 0 && value <= plateau.send(coord)
  end

  def show_position
    puts "#{x} #{y} #{orientation}"
  end
end

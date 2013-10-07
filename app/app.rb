require 'plateau'
require 'rover'

class App
  attr_reader :data

  INPUT_MAPPING = {
    'L' => :spin_left,
    'R' => :spin_right,
    'M' => :move_forward
  }

  # Instances the {App} and saves the input.
  # @param [String] file_name the file name path with the input.
  def initialize(file_name)
    @data = File.open(file_name, 'r').read.split("\n")
  end

  # Runs the application using the saved data. Gets the first line of
  # the data and instances a {Plateau}. Later iterates over the data
  # and instances and moves a {Rover}.
  def run
    lines = data.dup
    size_line = lines.shift
    plateau = Plateau.new(parse_coordinates(size_line))

    lines.each_slice(2) do |position_line, instructions_line|
      position = parse_position(position_line)
      rover = Rover.new(plateau, position)

      move_rover(rover, instructions_line)
      rover.show_position
    end
  end

  # Receives a {Rover} and the instructions and sends them to the {Rover}.
  # @param [Rover] rover the rover to move
  # @param [String] instructions the instructions to send to the {Rover}
  def move_rover(rover, instructions)
    instructions.each_char do |char|
      method = method_from_char(char)

      unless method
        raise 'Wrong statement: #{char}'
      end
      rover.send(method)
    end
  end

  # Parses the coordinates line and returns an array
  # @param [String] line the string with the {Plateu} coordinates
  def parse_coordinates(line)
    line.split(' ')
  end

  # Parses the position line and returns an array
  def parse_position(line)
    line.split(' ')
  end

  # Gets the {Rover} method to use for the char received
  # @param [String] char the char to find in the {INPUT_MAPPING} hash
  # @return [Symbol, NilClass]
  def method_from_char(char)
    INPUT_MAPPING[char]
  end
end

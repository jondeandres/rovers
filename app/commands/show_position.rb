module Commands
  class ShowPosition
    extend Rovers::Command

    def call(rover)
      puts "#{rover.x} #{rover.y} #{rover.orientation}"
    end
  end
end

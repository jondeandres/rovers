require 'rover'
require 'rovers/command'

module Commands
  class LaunchRocket
    extend Rovers::Command

    def call(rover, coords)
      puts "Launching rocket to: #{coords.join(', ')}!!!"
    end
  end
end

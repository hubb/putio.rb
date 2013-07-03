require 'thor'

module PutIO
  class Cli < Thor
    desc "test", "1st task"
    def test
      puts "Woot!"
    end
  end
end
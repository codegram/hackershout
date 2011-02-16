module Hackershout
  module Output

    def print(str)
      $stdout.print str
    end

    def blank
      print "\n"
    end

  end
end

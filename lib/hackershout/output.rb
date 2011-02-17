module Hackershout
  module Output

    def print(str)
      $stdout.print "\n" + str
    end

    def blank
      print "\n"
    end

  end
end

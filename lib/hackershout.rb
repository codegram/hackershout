require 'hackershout/output'
require 'hackershout/provider'
require 'hackershout/provider/base'
require 'hackershout/provider/reddit'
require 'hackershout/provider/hackernews'
require 'hackershout/provider/rubyflow'
require 'hackershout/base'

module Hackershout
  class << self
    def run
      Base.new.run
    end
  end
end

require 'hackershout/output'
require 'hackershout/provider'
require 'hackershout/base'
require 'nokogiri'
require 'mechanize'

module Hackershout
  class << self
    def run
      Base.new.run
    end
  end
end

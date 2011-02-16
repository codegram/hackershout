require 'hackershout/output'

module Hackershout
  class Base
    include Output

    def initialize
      @url = nil
      @tags = nil
      @message = nil
      @providers = []
    end

    def run
      welcome_banner
      @url = ask_for_url
      @message = ask_for_message
    end

    def welcome_banner
      blank
      print ":: Welcome to hackershout! ::"
      blank
    end

    def ask_for_url
      print "Type the URL you want to share: "
      gets.chomp.strip
    end

    def ask_for_message
      print "Type your message (two ENTERs to finish): "
      $/ = "\n\n"
      gets.chomp.strip
    end

  end
end

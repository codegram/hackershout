require 'hackershout/output'

module Hackershout
  class Base
    include Output

    def initialize
      @url = nil
      @tags = nil
      @message = nil
      @tags = []
      @providers = []
    end

    def run
      welcome_banner
      @url = ask_for_url
      @message = ask_for_message
      @tags = ask_for_tags
      providers_banner

      @providers = ask_for_providers
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
      gets.chomp.strip.tap do
        # Restore EOM char
        $/ = "\n"
      end
    end

    def ask_for_tags
      print "Type some tags separated by comma (i.e. ruby, rails, bdd): "
      gets.chomp.strip.split(',').map(&:strip)
    end

    def providers_banner
      print "...Got it! Now where would you want to spread the word?"
    end

    def ask_for_providers
      Provider.list.keys.select do |provider|
        Provider.wants?(provider)
      end
    end

  end
end

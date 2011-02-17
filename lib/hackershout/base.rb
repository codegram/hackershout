require 'hackershout/output'

module Hackershout
  class Base
    include Output

    def initialize(options = {})
      @url = options[:url]
      @title = options[:title]
      @message = options[:message]
      @tags = options[:tags] || []
      @providers = options[:providers] || []
    end

    def run
      welcome_banner
      @url = ask_for_url
      @title = ask_for_title
      @message = ask_for_message
      @tags = ask_for_tags
      providers_banner

      @providers = ask_for_providers
      post_to_providers
    end

    def welcome_banner
      print ":: Welcome to hackershout! ::"
      blank
    end

    def ask_for_url
      print "Type the URL you want to share: "
      gets.chomp.strip
    end

    def ask_for_title
      print "Enter a brief, descriptive title: "
      gets.chomp.strip
    end

    def ask_for_message
      print "Bear in mind that some services may require a more extended text aside from the title."
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

    def post_to_providers
      print "Fine."
      @providers.map do |provider|
        eval("Provider::#{provider.capitalize}").new({ 
          url:     @url,
          title:   @title,
          message: @message,
          tags:    @tags,
        })
      end.each do |provider|
        provider.publish
      end
      puts "Done. Happy hacking! :)\n"
    end

  end
end

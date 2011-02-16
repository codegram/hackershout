module Hackershout
  module Provider
    class << self

      include Output

      def list
        {
          :reddit     => 'Ruby Reddit',
          :hackernews => 'Hackernews',
          :rubyflow   => 'RubyFlow',
        }
      end

      def wants?(provider)
        name = list[provider]
        print "\t#{name} (y/n)? "
        return case gets.chomp
          when 'y'
            check_credentials_for(provider)
          when 'n'
            false
          else
            blank
            print "I don't understand. Just type y for yes and n for no :)"
            wants?(provider)
        end
      end

      private

      def check_credentials_for(provider)
         
      end

    end
  end
end

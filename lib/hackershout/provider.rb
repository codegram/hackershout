module Hackershout
  module Provider
    class << self

      include Output

      def list
        {
          # :reddit     => 'Ruby Reddit',
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
        credentials = YAML.load(File.read(File.join(File.expand_path('~'), '.hackershoutrc')))

        if credentials[provider.to_s] &&
             credentials[provider.to_s]["login"] &&
             credentials[provider.to_s]["password"]
          true
        else
          ask_for_credentials(provider)
        end
      rescue Errno::ENOENT # If the file doesn't even exist
        ask_for_credentials(provider)
      end

      def ask_for_credentials(provider)
        print "Sorry, I don't have your #{list[provider]} credentials."
        print "\tLogin: "
        login = gets.chomp.strip
        system('stty -echo')
        print "\tPassword: "
        password = gets.chomp.strip
        system('stty echo')
        File.open(File.join(File.expand_path('~'), '.hackershoutrc'), 'a') do |file|
          file.write "\n#{provider}:"
          file.write "\n  login: #{login}"
          file.write "\n  password: #{password}"
        end
      end

    end
  end
end

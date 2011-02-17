module Hackershout
  module Provider
    class Reddit < Base

      URL = {
        :login => 'http://www.reddit.com/r/ruby/',
        :submit => 'http://www.reddit.com/r/ruby/submit',
      }

      # Not logging in! :(
      def post
        raise NotImplementedError
        page = agent.get(URL[:login])
        login_form = page.forms_with(:action => 'http://www.reddit.com/r/ruby/post/login').first
        login_form.user = @login
        login_form.passwd = @password
        page = login_form.submit
        puts page.links_with(:text => 'logout').inspect
        page = page.links_with(:text => 'Submit a link').first.click
        puts page.inspect

      rescue Mechanize::ResponseCodeError=>e
        puts "#{@name} is unavailable for now. Please try in a few minutes. The server gave the following reason:"
        puts e.inspect
      end

    end
  end
end

module Hackershout
  module Provider
    class Rubyflow < Base

      URL = {
        :login => 'http://www.rubyflow.com/login'
      }

      def post
        page = agent.get(URL[:login])
        login_form = page.form_with(:action => '/session')
        login_form.login = @login
        login_form.password = @password
        page = login_form.submit
        page = page.link_with(:href => /items\/new/).click
        submit(page) 
      end

      private

      def submit(submit_page)
        form = submit_page.form_with(:action => '/items')
        form['item[title]'] = @title
        form['item[content]'] = process(@message)
        form.submit
      end

      def process(message)
        message.gsub!('<link>', "<a href=\"#{@url}\">")
        message.gsub!('</link>', "</a>")
        message
      end

    end
  end
end

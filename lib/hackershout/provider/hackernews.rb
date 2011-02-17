module Hackershout
  module Provider
    class Hackernews < Base

      URL = {
        :login => 'http://news.ycombinator.com/submit'
      }

      def post
        page = agent.get(URL[:login])
        login_form = page.forms.first
        login_form.u = @login
        login_form.p = @password
        page = login_form.submit
        submit(page) 
      end

      private

      def submit(submit_page)
        form = submit_page.forms.first
        form.t = @title
        form.u = @url
        form.submit
      end

    end
  end
end

require 'mechanize'
require 'nokogiri'

Mechanize.html_parser = Nokogiri::HTML

module Hackershout
  module Provider
    class Base
      attr_reader :agent

      include Output

      def initialize(options = {})
        @name = self.class.name.split("::").last
        @url = options[:url] << "&utm_medium=#{@name.downcase}"
        @title = options[:title]
        @tags = options[:tags]
        @message = options[:message]

        creds = YAML.load(File.read(File.join(File.expand_path('~'), '.hackershoutrc')))[@name.downcase]
        raise "Can't find credentials on ~/.hackershoutrc for #{@name}" unless creds

        @login = creds["login"]
        @password = creds["password"]
        @agent = Mechanize.new
      end

      def publish
        print "Posting to #{@name}..."
        post unless ENV['NOSEND']
        print "Posted to #{@name}!"
      end

      def post
        raise NotImplementedError
      end

    end
  end
end

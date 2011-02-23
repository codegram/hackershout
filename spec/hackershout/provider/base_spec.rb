require 'spec_helper'

module Hackershout
  module Provider
    describe Base do

      # Test only base class. Each provider only implements #post with pure Mechanize logic.

      before do
        File.stub(:read).and_return """
        base:
          login: my.email@gmail.com
          password: mypassword
        """
      end

      describe "#initialize" do
        it 'reads the credentials and stores them' do
          base = Base.new(:url => 'url',
                          :tags => ['my', 'tags'],
                          :message => 'message')

          base.instance_variable_get(:@login).should eq('my.email@gmail.com')
          base.instance_variable_get(:@password).should eq('mypassword')
          base.instance_variable_get(:@agent).should be_a(Mechanize)
          base.instance_variable_get(:@url).should == 'url&utm_medium=base'
        end
      end

      describe "#publish" do
        it 'logs in and posts' do
          base = Base.new(:url => 'url',
                          :tags => ['my', 'tags'],
                          :message => 'message')

          base.should_receive(:post)

          base.publish
        end
      end

      it 'crap' do
        File.stub(:read).and_return """
        hackernews:
          login: codegram
          password: codgamerP90
        """
        Hackernews.new(:title => 'my title', :message => 'my message', :url => 'http://google.com').post
      end

    end
  end
end

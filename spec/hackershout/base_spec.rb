require 'spec_helper'

module Hackershout
  describe Base do

    describe ".run" do
      it 'calls welcome banner' do
        subject.should_receive(:welcome_banner)
        subject.run
      end
      it 'calls ask_for_url' do
        subject.should_receive(:ask_for_url)
        subject.run
      end
      it 'calls ask_for_message' do
        subject.should_receive(:ask_for_message)
        subject.run
      end
    end

    describe "#welcome_banner" do
      it 'prints the welcome banner' do
        subject.should_receive(:blank).any_number_of_times
        subject.should_receive(:print).with(":: Welcome to hackershout! ::")
        subject.welcome_banner
      end
    end

    describe "#ask_for_url" do
      it 'asks for the url and returns it' do
        subject.should_receive(:print).with("Type the URL you want to share: ")
        subject.should_receive(:gets).and_return '  http://rubygems.org/gems/my_gem '
        subject.ask_for_url.should == 'http://rubygems.org/gems/my_gem'
      end
    end

    describe "#ask_for_message" do
      it 'asks for the message and returns it' do
        subject.should_receive(:print).with("Type your message (two ENTERs to finish): ")

        subject.should_receive(:gets).and_return("""
          Hey! I have released <link>some awesome open-source gem</link> that is
          going to save the world.\nCheck it out! You can also grab the source code
          on <a href=\"http://github.com/me/my_gem\">Github</a> if you want.
          
        """)
        subject.ask_for_message.should == "Hey! I have released <link>some awesome open-source gem</link> that is going to save the world.\nCheck it out! You can also grab the source code on <a href=\"http://github.com/me/my_gem\">Github</a> if you want."
      end
    end

  end
end

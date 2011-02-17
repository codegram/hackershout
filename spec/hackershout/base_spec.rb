require 'spec_helper'

module Hackershout
  describe Base do

    describe ".run" do
      before do
        subject.stub(:welcome_banner)
        subject.stub(:ask_for_url)
        subject.stub(:ask_for_message)
        subject.stub(:ask_for_title)
        subject.stub(:ask_for_tags)
        subject.stub(:providers_banner)
        subject.stub(:ask_for_providers)
        subject.stub(:post_to_providers)
      end
      it 'calls welcome banner' do
        subject.should_receive(:welcome_banner)
        subject.run
      end
      it 'calls ask_for_url' do
        subject.should_receive(:ask_for_url)
        subject.run
      end
      it 'calls ask_for_title' do
        subject.should_receive(:ask_for_title)
        subject.run
      end
      it 'calls ask_for_message' do
        subject.should_receive(:ask_for_message)
        subject.run
      end
      it 'calls ask_for_tags' do
        subject.should_receive(:ask_for_tags)
        subject.run
      end
      it 'calls providers_banner' do
        subject.should_receive(:providers_banner)
        subject.run
      end
      it 'calls ask_for_providers' do
        subject.should_receive(:ask_for_providers)
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

    describe "#ask_for_title" do
      it 'asks for the title and returns it' do
        subject.should_receive(:print).with("Enter a brief, descriptive title: ")
        subject.should_receive(:gets).and_return '   Released my gem: a nifty gem to eradicate hunger!   '
        subject.ask_for_title.should == 'Released my gem: a nifty gem to eradicate hunger!'
      end
    end

    describe "#ask_for_message" do
      it 'asks for the message and returns it' do
        subject.should_receive(:print).with("Bear in mind that some services may require a more extended text aside from the title.")
        subject.should_receive(:print).with("Type your message (two ENTERs to finish): ")
        subject.should_receive(:gets).and_return("""
Hey! I have released <link>some awesome open-source gem</link> that is
going to save the world.\nCheck it out! You can also grab the source code
on <a href=\"http://github.com/me/my_gem\">Github</a> if you want.
          
        """)
        subject.ask_for_message
      end
    end

    describe "#ask_for_tags" do
      it 'asks for the tags and returns them' do
        subject.should_receive(:print).with("Type some tags separated by comma (i.e. ruby, rails, bdd): ")
        subject.should_receive(:gets).and_return ' ruby  , bdd, rails,  parsing '
        subject.ask_for_tags.should == %w( ruby bdd rails parsing )
      end
    end

    describe "#providers_banner" do
      it 'prints the providers banner' do
        subject.should_receive(:print).with("...Got it! Now where would you want to spread the word?")
        subject.providers_banner
      end
    end

    describe "#ask_for_providers" do
      it 'asks for providers' do
        providers = [:reddit, :hackernews, :rubyflow]
        Provider.stub_chain('list.keys').and_return providers
        Provider.should_receive(:wants?).with(:reddit).and_return true
        Provider.should_receive(:wants?).with(:hackernews).and_return false
        Provider.should_receive(:wants?).with(:rubyflow).and_return true

        subject.ask_for_providers.should == [:reddit, :rubyflow]
      end
    end

    describe "#post_to_providers" do
      it 'instantiates each provider and calls #publish on it' do
        args = {
          :url     => 'http://rubygems.org/gems/my_gem',
          :title   => 'Released MyGem!',
          :tags    => ['ruby', 'bdd'],
          :message => 'Hello!',
        }
        base = Base.new({:providers => [:reddit, :hackernews]}.update(args))
        base.stub(:print)

        hackernews = double :provider 
        reddit = double :provider 

        Provider::Hackernews.should_receive(:new).with(args).and_return hackernews
        Provider::Reddit.should_receive(:new).with(args).and_return reddit

        hackernews.should_receive(:publish)
        reddit.should_receive(:publish)

        base.post_to_providers
      end
    end

  end
end

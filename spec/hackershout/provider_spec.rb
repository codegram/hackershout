require 'spec_helper'

module Hackershout
  describe Provider do

    describe "#list" do
      it 'returns a hash' do
        subject.list.should == {
          :reddit => 'Ruby Reddit',
          :hackernews => 'Hackernews',
          :rubyflow => 'RubyFlow',
        }
      end
    end

    describe "#wants?(provider)" do
      before do
        subject.should_receive(:print).with("\tRuby Reddit (y/n)? ")
      end
      context 'if the user wants to publish on a provider' do
        it 'checks the credentials' do
          subject.should_receive(:gets).and_return 'y'
          subject.should_receive(:check_credentials_for).with(:reddit)
          subject.wants?(:reddit)
        end
      end
      context 'if the user doesn\'t want' do
        it 'returns false' do
          subject.should_receive(:gets).and_return 'n'
          subject.wants?(:reddit).should be_false
        end
      end
    end

    describe "#check_credentials_for(provider)" do

      context 'if the credentials exist' do
        it 'returns true' do
          File.stub(:read).and_return "reddit:\n  login: my.email@gmail.com\n  password: mypassword"
          subject.should_not_receive(:ask_for_credentials)
          subject.send(:check_credentials_for, :reddit).should be_true
        end
      end

      context 'otherwise' do
        it 'asks for them' do
          File.stub(:read).and_return "hackernews:\n  login: my.email@gmail.com\n  password: mypassword"
          subject.should_receive(:ask_for_credentials).with(:reddit)
          subject.send(:check_credentials_for, :reddit)
        end
      end

      context "if the file doesn't even exist" do
        it 'asks for the credentials as well' do
          File.stub(:read).and_raise Errno::ENOENT
          subject.should_receive(:ask_for_credentials).with(:reddit)
          subject.send(:check_credentials_for, :reddit)
        end
      end

    end

    describe "#ask_for_credentials(provider)" do
      it 'asks for the credentials and saves them into ~/.hackershoutrc' do
        subject.stub(:print)
        file = double :file
        subject.should_receive(:gets).and_return 'my.email@gmail.com'
        subject.should_receive(:gets).and_return 'mypassword'
        File.should_receive(:open).and_yield file

        file.should_receive(:write).with "\nreddit:"
        file.should_receive(:write).with "\n  login: my.email@gmail.com"
        file.should_receive(:write).with "\n  password: mypassword"

        subject.send(:ask_for_credentials, :reddit)
      end
    end

  end
end

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

  end
end

# Entrat a les 9.15
# Hora 13:10
#
# Entrat altre cop a les 14.19

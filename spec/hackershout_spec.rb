require 'spec_helper'

describe Hackershout do

  describe ".run" do
    it 'calls run on a new Base instance' do
      Hackershout::Base.should_receive(:new).and_return(double(:base).tap { |b| 
        b.should_receive(:run)
      })
      subject.run
    end
  end

end

require 'spec_helper'

describe "Get Files" do
  
  context "invalid login" do
    before(:each) do
      @result = Sp2010::Client.get_files(ENV["SP_2010_HOST"], ENV["SP_2010_USERNAME"], "badpassword")
    end
    it { @result.should_not be_valid }
    it { @result.files.count.should == 0 }
  end
  
  context "valid" do
    before(:each) do
      @result = Sp2010::Client.get_files(ENV["SP_2010_HOST"], ENV["SP_2010_USERNAME"], ENV["SP_2010_PASSWORD"])
    end
    it { @result.should_not be_nil }
    it { @result.files.count.should > 0 }
  end
  
end
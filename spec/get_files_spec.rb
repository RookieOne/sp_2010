require 'spec_helper'

describe "Get Files" do
  
  context "invalid login" do
    before(:each) do
      @result = Sp2010::Client.get_files({
        :host => ENV["SP_2010_HOST"], 
        :user => ENV["SP_2010_USERNAME"], 
        :password => "badpassword"
        })      
    end
    it { @result.should_not be_valid }
    it { @result.files.count.should == 0 }
  end
  
  context "valid" do
    before(:each) do
      @result = Sp2010::Client.get_files({
        :host => ENV["SP_2010_HOST"], 
        :user => ENV["SP_2010_USERNAME"], 
        :password => ENV["SP_2010_PASSWORD"]
        })      
    end
    it { @result.files.count.should > 0 }
  end
  
  context "valid scenario 2" do
    before(:each) do
      @result = Sp2010::Client.get_files({
        :host => ENV["SP_2010_HOST_2"], 
        :domain => ENV["SP_2010_DOMAIN_2"],
        :user => ENV["SP_2010_USERNAME_2"], 
        :password => ENV["SP_2010_PASSWORD_2"]
        })
    end
    it { @result.files.count.should > 0 }
  end  
  
  context "valid scenario 3" do
    before(:each) do
      @result = Sp2010::Client.get_files({
        :host => ENV["SP_2010_HOST_3"], 
        :user => ENV["SP_2010_USERNAME_3"], 
        :password => ENV["SP_2010_PASSWORD_3"]
        })
    end
    it { @result.files.count.should > 0 }
  end 
  
end
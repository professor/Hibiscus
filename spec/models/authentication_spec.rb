require 'spec_helper'

describe Authentication do
  before(:each) do
    @authentication = FactoryGirl.build(:authentication)
  end
  
  describe "Required fields: " do
    it "should be invalid without a provider" do
      @authentication.provider = nil
      @authentication.should be_invalid
      
      @authentication.provider = ""
      @authentication.should be_invalid
      
      @authentication.provider = " "
      @authentication.should be_invalid
    end
    
    it "should be invalid without an uid" do
      @authentication.uid = nil
      @authentication.should be_invalid
      
      @authentication.uid = ""
      @authentication.should be_invalid
      
      @authentication.uid = " "
      @authentication.should be_invalid
    end
    
    it "should be invalid without a user" do
      @authentication.user = nil
      @authentication.should be_invalid
    end
    
    it "should be valid with a provider, a uid, and a user" do
      @authentication.should be_valid_verbose
    end
  end
end

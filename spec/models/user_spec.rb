require 'spec_helper'

describe User do
  
  before(:each) do
    @user = Factory.build(:user)
  end
  
  describe "required fields: " do
    it "should be invalid without a name" do
      @user.name = nil
      @user.should be_invalid
      
      @user.name = ""
      @user.should be_invalid
      
      @user.name = " "
      @user.should be_invalid
    end
    
    it "should be invalid without an email" do
      @user.email = nil
      @user.should be_invalid
      
      @user.email = ""
      @user.should be_invalid
      
      @user.email = " "
      @user.should be_invalid
    end
    
    it "should be invalid without a proper email" do
      @user.email = "ckent"
      @user.should be_invalid
      
      @user.email = "ckent@"
      @user.should be_invalid
      
      @user.email = "ckent@cmu"
      @user.should be_invalid
      
      @user.email = "ckent@cmu."
      @user.should be_invalid
      
      @user.email = "ckent@cmu.e"
      @user.should be_invalid
    end
    
    it "should be valid with a name and a proper email" do
      @user.should be_valid
    end
  end
  
  
end

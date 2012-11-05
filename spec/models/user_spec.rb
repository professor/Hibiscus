require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.build(:user)
  end

  it { should respond_to(:points) }
  it { should respond_to(:email) }
  it { should respond_to(:gravatar_email) }

  describe "Required fields: " do
    it "should be invalid without a username" do
      @user.username = nil
      @user.should be_invalid
      
      @user.username = ""
      @user.should be_invalid
      
      @user.username = " "
      @user.should be_invalid
    end
    
    it "should be valid with a username" do
      @user.should be_valid_verbose
    end
  end


end

require 'spec_helper'

describe ActsAsVoter do

  describe "test instance methods" do
    before(:each) do
      @user_for = FactoryGirl.build(:user, name:"Good Guy Greg")
      @user_against = FactoryGirl.build(:user, name:"Scumbag Steve")
      @kata = FactoryGirl.build(:kata)
      @review = FactoryGirl.build(:review)
    end

    @user_for.vote_for(@review)
    @user_against.vote_against(@review)

    it "is true that Greg voted up" do
      @user_for.should be_voted_for?(@review)
    end

  end

  #before(:each) do
  #  @user = FactoryGirl.build(:user)
  #end
  #
  #it { should respond_to(:points) }
  #it { should respond_to(:email) }
  #it { should respond_to(:gravatar_email) }
  #it { should respond_to(:digest_frequency) }
  #
  #describe "Required fields: " do
  #  it "should be invalid without a username" do
  #    @user.username = nil
  #    @user.should be_invalid
  #
  #    @user.username = ""
  #    @user.should be_invalid
  #
  #    @user.username = " "
  #    @user.should be_invalid
  #  end
  #
  #  it "should be valid with a username" do
  #    @user.should be_valid_verbose
  #  end
  #end


end

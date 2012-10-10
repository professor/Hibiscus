require 'spec_helper'

describe Comment do
  before(:each) do
    @comment = FactoryGirl.build(:comment)
  end
  
  describe "Required fields: " do    
    it "should be invalid without a content" do
      @comment.content = nil
      @comment.should be_invalid
      
      @comment.content = ""
      @comment.should be_invalid
      
      @comment.content = " "
      @comment.should be_invalid
    end
    
    it "should be invalid without a user" do
      @comment.user = nil
      @comment.should be_invalid
    end
    
    it "should be valid with a valid title and some valid content" do
      @comment.should be_valid_verbose
    end
  end
end

require 'spec_helper'

describe Post do
  before(:each) do
    @post = Factory.build(:post)
  end
  
  describe "Required fields: " do
    it "should be invalid without a title" do
      @post.title = nil
      @post.should be_invalid
      
      @post.title = ""
      @post.should be_invalid
      
      @post.title = " "
      @post.should be_invalid
    end
    
    it "should be invalid without a content" do
      @post.content = nil
      @post.should be_invalid
      
      @post.content = ""
      @post.should be_invalid
      
      @post.content = " "
      @post.should be_invalid
    end
    
    it "should be invalid without a user" do
      @post.user = nil
      @post.should be_invalid
    end
    
    it "should be invalid without isKata" do
      @post.isKata = nil
      @post.should be_invalid
    end
    
    it "should be valid with a valid title and some valid content" do
      @post.should be_valid_verbose
    end
  end
end

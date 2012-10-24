require 'spec_helper'

describe Post do
  before(:each) do
    @post = FactoryGirl.build(:post)
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

    it "should be valid without a source" do
      @post.source = nil
      @post.should be_valid
    end

    it "should be valid without a rating" do
      @post.rating = nil
      @post.should be_valid
    end
    
    it "should be invalid without a user" do
      @post.user = nil
      @post.should be_invalid
    end
    
    it "should be valid with a valid title and some valid content" do
      @post.should be_valid_verbose
    end
  end
  
  describe "listLikes method" do
    after(:each) do
      @post.listLikes
    end
    
    it "should look through all the likes" do
      @post.should_receive(:likes).and_return([])
    end
  end
  
  describe "listDislikes method" do
    after(:each) do
      @post.listDislikes
    end
    
    it "should look through all the likes" do
      @post.should_receive(:likes).and_return([])
    end
    
    it "should append to an array if the object is a like" do
      @post.should_receive(:likes).and_return([Like.new, Like.new])
    end
  end
  
  describe "update_search_index method" do
    after(:each) do
      @post.update_search_index("someurl")
    end
    
    it "should update the search index" do
      @post.should_receive(:update_search_index)
    end
  end

end

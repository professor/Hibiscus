require 'spec_helper'

describe Kata do
  before(:each) do
    @kata = Factory.build(:kata)
  end
  
  describe "Required fields: " do
    it "should be invalid without a title" do
      @kata.title = nil
      @kata.should be_invalid
    end
    
    it "should be invalid without any instructions" do
      @kata.instructions = nil
      @kata.should be_invalid
    end
  end
  
  describe "Unrequired fields: " do
    it "should be invalid with an incorrectly formatted link" do
      # Link requires http, https, or ftp as a prefix.
      @kata.link = "www.google.com"
      @kata.should be_invalid
    end
    
    it "should be invalid with an link not of the HTTP, HTTPS, or FTP protocol" do
      @kata.link = "smb://www.google.com"
      @kata.should be_invalid
    end
    
    it "should be valid without a link" do
      @kata.link = nil
      @kata.should be_valid
      
      @kata.link = ""
      @kata.should be_valid
      
      @kata.link = " "
      @kata.should be_valid
    end
  end
  
  it "should be valid with when all fields are correct" do
    @kata.should be_valid
  end
end
require 'spec_helper'

describe Tag do
  before(:each) do
    @tag = FactoryGirl.build(:tag)
  end
  
  describe "Required fields: " do
    it "should be invalid without a name" do
      @tag.name = nil
      @tag.should be_invalid
    end
    
    it "should be valid with a name" do
      @tag.should be_valid_verbose
    end
  end
end
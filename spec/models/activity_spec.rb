require 'spec_helper'

describe Activity do
  before(:each) do
    @activity = FactoryGirl.build(:activity)
  end
  
  describe "Required fields: " do
    it "should be invalid without a name" do
      @activity.name = nil
      @activity.should be_invalid
    end
    
    it "should be valid with a name" do
      @activity.should be_valid_verbose
    end
  end
end
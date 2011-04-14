require 'spec_helper'

describe Plan do
  before(:each) do
    @plan = Factory.build(:plan)
  end
  
  describe "Required fields: " do
    it "should be invalid without a user" do
      @plan.user = nil
      @plan.should be_invalid
    end
    
    it "should be valid with a user" do
      @plan.should be_valid
    end
  end
end
require 'spec_helper'

describe Katacomment do
  before(:each) do
    @katacomment = Factory.build(:katacomment)
    # @katacomment = Katacomment.new
    # @katacomment.recommendation = "Recommend"
    # @katacomment.timeSpent = "5 hours"
    # @katacomment.good = "Algorithm"
    # @katacomment.bad = "Nothing"
    # @katacomment.language = "Ruby"
    # @katacomment.ahhah = "None"
    # @katacomment.user_id = 1
    # # @katacomment.post_id = 1
  end
  
  describe "Required fields: " do
    it "should be invalid without a user" do
      @katacomment.user_id = nil
      @katacomment.should be_invalid
    end
  end
  
  it "should be valid with when all fields are correct" do
    @katacomment.should be_valid_verbose
  end
end
require 'spec_helper'

describe Kata do
  before(:each) do
    @kata = FactoryGirl.build(:kata)
  end

  describe "Required fields: " do
    it "is invalid without a challenge level" do
      @kata.challenge_level = nil
      @kata.should be_invalid
    end

    it "is valid with a challenge level in 'low, medium, high'" do
      @kata.challenge_level = "high"
      @kata.should be_valid
    end

    it "is invalid to have challenge level other than 'low, medium, high'" do
      @kata.challenge_level = "super high"
      @kata.should be_invalid
    end

    it "is invalid without a category" do
      @kata.category = nil
      @kata.should be_invalid
    end

    it "is valid without a user defined category" do
      @kata.user_categories = nil
      @kata.should be_valid
    end

  end

  describe "delete kata" do
    it "should delete from search index" do
      @kata.should_receive(:delete_from_search_index)
      @kata.destroy
    end
  end
end

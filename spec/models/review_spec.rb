#require "rspec"
require 'spec_helper'

describe Review do
  before(:each) do
    @review = FactoryGirl.build(:review)
  end

  describe "Required fields: " do
    it "should be valid without a content" do
      @review.content = nil
      @review.should be_valid

      @review.content = ""
      @review.should be_valid

      @review.content = " "
      @review.should be_valid
    end

    it "is valid without a user defined category" do
      @review.categories = nil
      @review.should be_valid
    end

    it "is valid with a challenge level in 'low, medium, high'" do
      @review.challenge_level = "high"
      @review.should be_valid
    end

    it "should be invalid without a user" do
      @review.user = nil
      @review.should be_invalid
    end

    it "should be valid with a valid title and some valid content" do
      @review.should be_valid_verbose
    end
  end

end
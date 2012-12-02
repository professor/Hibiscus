require 'spec_helper'

describe Flag do
  before(:each) do
    @flag = FactoryGirl.build(:flag)
  end
  
  describe "Required fields: " do
    it "should be invalid without an associated post" do
      @flag.post_id = nil
      @flag.should be_invalid

      @flag.post_id = ""
      @flag.should be_invalid

      @flag.post_id = " "
      @flag.should be_invalid
    end

    it "should be invalid without a user" do
      @flag.user = nil
      @flag.should be_invalid
    end

    it "should be valid with a valid post  and user associated" do
      @flag.should be_valid_verbose
    end
  end

  it "should not allow reporting if the user has already reported the post" do
    @flag.should validate_uniqueness_of(:user_id)
  end
end

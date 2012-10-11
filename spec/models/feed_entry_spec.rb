require 'spec_helper'

describe FeedEntry do
  before(:each) do
    @feed_entry = FactoryGirl.build(:feed_entry)
  end
  
  describe "Required fields: " do
    it "should be invalid without a guid" do
      @feed_entry.guid = nil
      @feed_entry.should be_invalid

      @feed_entry.guid = ""
      @feed_entry.should be_invalid

      @feed_entry.guid = " "
      @feed_entry.should be_invalid
    end

    describe "Required fields: " do
      it "should be invalid without a name" do
        @feed_entry.name = nil
        @feed_entry.should be_invalid

        @feed_entry.name = ""
        @feed_entry.should be_invalid

        @feed_entry.name = " "
        @feed_entry.should be_invalid
      end
    end

    it "should be valid with a valid title and some valid content" do
      @feed_entry.should be_valid_verbose
    end
  end

end

require 'spec_helper'

describe Article do
  before(:each) do
    @article = FactoryGirl.build(:article)
  end

  it { should respond_to(:author) }
  it { should respond_to(:site_name) }

  describe "Required fields: " do
    it "should be invalid without a id" do
      @article.id = nil
      @article.should be_invalid

      @article.id = ""
      @article.should be_invalid

      @article.id = " "
      @article.should be_invalid
    end

    describe "Required fields: " do
      it "should be invalid without a title" do
        @article.title = nil
        @article.should be_invalid

        @article.title = ""
        @article.should be_invalid

        @article.title = " "
        @article.should be_invalid
      end
    end

    describe "Required fields: " do
      it "should be invalid without a site name" do
        @article.site_name = nil
        @article.should be_invalid

        @article.site_name = ""
        @article.should be_invalid

        @article.site_name = " "
        @article.should be_invalid
      end
    end

    it "should be valid with a valid title and some valid site name" do
      @article.should be_valid_verbose
    end
  end

end

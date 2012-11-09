require "spec_helper"

describe "Posts" do

  before(:each) {sign_in_as_a_user}
  describe "GET /" do
    it "displays posts" do
      #it creates a post, list the index page and see if capybara can find it on the page
      FactoryGirl.create(:post, :title => "mock post", :user => @user)
      visit root_url
      page.should have_content("mock post")
    end
  end

  describe "GET /" do
    it "displays articles" do
      #it creates a post, list the index page and see if capybara can find it on the page
      FactoryGirl.create(:article, :title => "mock article", :user => @user)
      visit root_url
      page.should have_content("mock article")
    end
  end


end
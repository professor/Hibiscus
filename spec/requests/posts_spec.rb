require "spec_helper"

describe "Posts" do

  describe "GET /posts" do
    it "displays posts" do
      #it creates a post, list the index page and see if capybara can find it on the page
      FactoryGirl.create(:post, :title => "mock post")
      visit posts_path
      page.should have_content("mock post")
    end
  end

  describe "GET /" do
    it "displays posts" do
      #it creates a post, list the index page and see if capybara can find it on the page
      FactoryGirl.create(:post, :title => "mock post")
      visit root_url
      page.should have_content("mock post")
    end
  end

  describe "GET /" do
    it "displays articles" do
      #it creates a post, list the index page and see if capybara can find it on the page
      FactoryGirl.create(:article, :title => "mock article" )
      visit root_url
      page.should have_content("mock article")
      page.should have_xpath("//a[@target='_blank']")
    end
  end


end
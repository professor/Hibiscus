require "spec_helper"

describe "Posts" do

  before(:each) {login_integration}

  describe "GET /" do
    it "displays posts" do
      #it creates a post, list the index page and see if capybara can find it on the page
      sign_in_as_a_user
      @post = FactoryGirl.create(:post, :title => "mock post", :user => @user)
      visit root_path
      page.should have_content("mock post")
      visit post_path(@post)
      page.should have_content("Post Content Factory")
    end
  end

  describe "GET /" do
    it "displays articles" do
      #it creates a article, list the index page and see if capybara can find it on the page
      sign_in_as_a_user
      FactoryGirl.create(:article, :title => "mock article", :user => @user)
      visit root_path
      page.should have_content("mock article")
    end
  end

end
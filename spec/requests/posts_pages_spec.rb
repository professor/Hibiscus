require 'spec_helper'

describe "PostsPages" do
=begin
  describe "GET /posts_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_pages_index_path
      response.status.should be(200)
    end
  end
=end

  describe "create a new post" do
    it "signs in" , :js => true do
      visit 'http://127.0.0.1:3000/users/sign_in'
      click_link 'GitHub'
    end
  end
end

require 'spec_helper'
require "devise/test_helpers"

describe "Creating a new post " do
  include Devise::TestHelpers

    before (:each) do
      @user = Factory.create(:user)
      sign_in @user
    end


    it "create a new post" do
      visit '/'
      page.should have_content ("New Post")
      click_link "New Post"
      page.should have_content ("Title")
    end
end

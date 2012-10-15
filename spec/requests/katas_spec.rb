require 'spec_helper'

describe "Katas" do
  describe "GET /katas" do
    it "displays katas" do
      #it creates a kata, list the index page and see if capybara can find it on the page
      FactoryGirl.create(:kata, :title => "test kata")
      visit katas_path
      page.should have_content("test kata")
    end
  end


end

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

  describe "DELETE /katas", :js => true do
    before do
      login_integration
    end

    it "delete a kata when click on link", :js => true do
      #it emulates a user clicking the Delete link and see if the kata is deleted

      FactoryGirl.create(:kata, :title => "test kata")
      visit katas_path
      expect {
        #hack necessary to the confirm box not be displayed, cause apparently
        #there is no way to press the OK button with capybara/selenium
        page.evaluate_script('window.confirm = function() { return true; }')
        click_link('Delete')
        #sleep 2.seconds
      }.to change(Kata, :count).by(-1)
    end
  end

end

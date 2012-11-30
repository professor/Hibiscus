require 'spec_helper'

describe "Katas" do
  describe "GET /katas" do
    it "displays kata homepage" do
      #it creates a kata, list the index page and see if capybara can find it on the page
      FactoryGirl.create(:kata, :title => "test kata")
      visit katas_path
      page.should have_content("test kata")
    end

    it "displays links to katas" do
      #it creates a kata, list the index page and see if the link goes to the kata page
      FactoryGirl.create(:kata, :title => "test kata", :content => "test content")
      visit katas_path
      click_link('test kata')
      page.should have_content("test content")
    end

    it "displays links to create a kata" do
      visit katas_path
      page.should have_link("New Kata")
    end

  end

  before(:each) {login_integration}
  describe "POST /katas" do
    it "create katas" do
       visit root_path
       click_link 'New Post'
    end
  end

  describe "DELETE /katas", :js => true do

    it "delete a kata when click on link", :js => true do
      #it emulates a user clicking the Delete link and see if the kata is deleted
      sign_in_as_a_user
      @kata = FactoryGirl.create(:kata, :title => "test kata", :user => @user)
      visit kata_path(@kata)
      expect {
        #hack necessary to the confirm box not be displayed, cause apparently
        #there is no way to press the OK button with capybara/selenium
        page.evaluate_script('window.confirm = function() { return true; }')
        click_link('Delete')
        sleep 1.seconds
      }.to change(Kata, :count).by(-1)
    end
  end

end

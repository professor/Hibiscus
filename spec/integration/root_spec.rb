require 'spec_helper'

describe "Sign-in process" do

  describe "testing oauth login " do
      before(:each) do
        @user = Factory(:user)
        #visit new_user_session_path
        #fill_in "Email", :with => @user.email
        #fill_in "Password", :with => @user.password
        #click_button
      end

      login_with_oauth
      visit '/'

      fill_in 'email', :with => @user.email
      fill_in 'password', :with => @user.password

      click_on "Github"
      page.should have_content("Signed in as ")


    #it "should ask user to enter login credentials" do
    #  visit new_user_session_path
    #  page.should have_content ("Sign in with GitHub")
    #  save_and_open_page
    #  click_link "GitHub"
    #  page.should have_content ("You are now signed in")
    #end

    it 'show the root page' do

      visit '/'
    #  save_and_open_page()
      page.should have_content('Home')
      page.should have_content('Katas')
      page.should have_content('Logged in as ')
      page.should have_content('Logout')
    end

    it "should show user's github handle'" do
      page.should have_content("#{@user.username}")
    end
  end
end


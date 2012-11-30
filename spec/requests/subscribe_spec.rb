require "spec_helper"

describe "Subscribe" do

  describe " Unsubscribe /" , :js => true do
    it "unsubscribe user" , :js => true do

      sign_in_as_a_user
      visit root_path

      page.should have_link("Logout")
      page.should have_link("Subscribe")

      visit user_path(@user)
      page.should have_content("Digest Frequency: Weekly")

      visit root_path + 'unsubscribe/' + @user.id.to_s
      page.should have_content("You have been unsubscribed")

      visit user_path(@user)
      page.should have_content("Digest Frequency:")
      page.should have_link("Logout")
      page.should have_link("Subscribe")

      ## Trying to subscribe the user then check Digest Frequency is set
      ## But unable to get the subscribe popup to work. tried the following
      ##
      ## click_link("Subscribe")
      ## page.execute_script("$('.promptmaindiv').show()");

      ##  visit user_path(@user)
      ##  page.should have_content("Digest Frequency: Weekly")

      visit root_path + 'unsubscribe/someInvalidUser'
      page.should have_content("Unsubscribe Process Unsuccessful. User does not exist.")
    end
  end
end
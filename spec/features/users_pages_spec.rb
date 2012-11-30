require 'spec_helper'

describe "User pages" do

  before(:each) {login_integration}

  describe "GET / " do
    it "displays user" do
      sign_in_as_a_user
      visit user_path(@user)
      page.should have_content(@user.name)
      page.should have_content("Email:")
      page.should have_content("Gravatar Email:")
      page.should have_content("Points: 0")
      page.should have_content("Digest Frequency: Weekly")
      page.should have_link('Change your avatar at Gravatar.com', href: 'http://gravatar.com/emails')
    end
  end

end
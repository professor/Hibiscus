require 'spec_helper'

describe "User pages" do

  context "regular user" do
    before(:each) do
      sign_in_as_a_user
    end
    before(:each) {login_integration}

    describe "profile page" do
      it "should display the user name" do
        visit user_path(@user)
        within("#profile_div") { page.should have_content("#{@user.display_name}") }
      end
    end
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

    context "admin user" do
      before(:each) do
        sign_in_as_an_admin
        @user1 = FactoryGirl.create(:user)
        @user2 = FactoryGirl.create(:user)
        @user3 = FactoryGirl.create(:user)
      end

      describe "kata index page" do
        it "should display a list of user" do
          visit users_path
          page.should have_content("#{@user1.name}")
          page.should have_content("#{@user2.name}")
          page.should have_content("#{@user3.name}")
        end

        it "should display regular (not blocked) users" do
          visit users_path
          page.should have_content("Block")
        end

        it "should display blocked users" do
          @user1.destroy
          visit users_path
          page.should have_content("Unblock")
          page.should have_content("Delete")
        end

      end
    end
  end

end
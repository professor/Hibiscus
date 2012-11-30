require "spec_helper"

describe "Points" do

  before(:each) {login_integration}

  describe " Show me the points /" , :js => true do
    it "earn post points" , :js => true do
      sign_in_as_a_user

      visit user_path(@user)
      page.should have_content("Points: 0")

      visit root_path
      page.should have_content("0")
      page.should have_link("New Post")
      click_link 'New Post'
      fill_in 'Title', :with => 'My first post'
      fill_in_ckeditor 'post_content', :with => 'This is my first post! Clark Kent was here.'
      click_button 'Create Post'
      page.should have_content("Post was successfully created")
      page.should have_content("My first post")
      page.should have_content("This is my first post!")

      visit user_path(@user)
      page.should have_content("Points: 10")

      sign_in_as_a_user
      visit root_path
      page.should have_content("10")
      click_link 'My first post'

      fill_in 'Comment', :with => 'My first comment! Show me the points!'
      click_button 'Create Comment'
      page.should have_content("Thank you for your comment")
      page.should have_content("1 Comment")
      page.should have_content("My first comment!")

      visit user_path(@user)
      page.should have_content("Points: 15")

      visit root_path
      page.should have_content("15")
      click_link 'My first post'
      #removed like button
      find("img[@alt='Upvote']").click


      visit user_path(@user)
      page.should have_content("Points: 16")
      visit root_path
      page.should have_content("16")
    end
  end

  def fill_in_ckeditor(locator, opts)
    browser = page.driver.browser
    content = opts.fetch(:with).to_json
    browser.execute_script <<-SCRIPT
    CKEDITOR.instances['#{locator}'].setData(#{content});
    $('textarea##{locator}').text(#{content});
    SCRIPT
  end
end
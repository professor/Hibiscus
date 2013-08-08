require "spec_helper"

describe "Search" do
  context "When the user searches for" do
    before(:each) do
      login_integration
      sign_in_as_a_user
    end

    it "nothing - page should render" do
      click_button('search-box-button')
      current_path.should == search_index_path
    end

    it "valid string - page should show the results", :skip_on_build_machine => true do
      fill_in "search-box", :with => "Search String"
      click_button('search-box-button')
      page.should have_content('Your search for "Search String" returned')
    end

    describe "invalid string" do
      it "like '-+_' - the page should not tank", :skip_on_build_machine => true do
        fill_in "search-box", :with => "-+_"
        click_button('search-box-button')
        current_path.should == search_index_path
        page.should have_content('Your search for "-+_" returned 0 results')
      end
      it "like '-%20%3C/p%3E%20-' - the page should not tank", :skip_on_build_machine => true do
        fill_in "search-box", :with => "-%20%3C/p%3E%20-"
        click_button('search-box-button')
        page.should have_content('Your search for "-%20%3C/p%3E%20-" returned 0 results')
      end
    end
  end
end

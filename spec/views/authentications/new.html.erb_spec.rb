require 'spec_helper'

describe "authentications/new.html.erb" do
  before(:each) do
    assign(:authentication, stub_model(Authentication,
      :user_id => 1,
      :provider => "MyString",
      :uid => "MyString"
    ).as_new_record)
  end

  it "renders new authentication form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => authentications_path, :method => "post" do
      assert_select "input#authentication_user_id", :name => "authentication[user_id]"
      assert_select "input#authentication_provider", :name => "authentication[provider]"
      assert_select "input#authentication_uid", :name => "authentication[uid]"
    end
  end
end

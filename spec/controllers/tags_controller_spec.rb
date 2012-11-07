require 'spec_helper'

describe TagsController do

  def mock_tag(stubs = {})
    @mock_tag ||= mock_model(Tag, stubs).as_null_object
  end

  context "Unauthenticated user: " do
    it "should allow access to viewing a tag" do
      Tag.should_receive(:find_by_slug).and_return(mock_tag)
      get :show, :id => mock_tag
      response.should be_success
    end
  end

  context "Authenticated user: " do
    before(:each) do
      login
    end
  end
end

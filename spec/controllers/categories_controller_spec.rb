require 'spec_helper'

describe CategoriesController do

  def mock_category(stubs = {})
    @mock_category ||= mock_model(Category, stubs).as_null_object
  end

  def mock_kata(stubs = {})
    @mock_kata ||= mock_model(Kata, stubs).as_null_object
  end

  describe "GET 'index'" do
    it "returns http success" do
      pending
      #get 'index'
      #response.should be_success
    end
  end

  describe 'GET show' do
    it "returns katas in that category" do
      Category.stub(:find_by_slug).with("37") { mock_category }
      Kata.stub(:where).with()
      get :show, :id => "37"
      assigns(:category).should be(@mock_category)

    end
  end

end

require 'spec_helper'

describe SearchController do

  describe "search box input" do
    it "calls the search method in controller" do
      SearchController::should_receive(:search).with("anything")
      get :index, :query => "anything"
    end
  end


end
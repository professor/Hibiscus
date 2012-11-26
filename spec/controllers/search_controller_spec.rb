require 'spec_helper'

describe SearchController do

  describe "search box input" do
    it "calls the search method in controller" do
      SearchController::should_receive(:search).with("anything")
      get :index, :query => "anything"
    end

    it "filters non allowed characters and if remaining query is still valid should call index_tank" do
      index_mocked = double("index object")
      index_mocked.should_receive(:search).with("aaa bbbb* OR title:aaa bbbb*", :fetch => 'timestamp,url,text,title', :snippet => 'text')
      SearchController::should_receive(:index_tank).with(any_args()).and_return(index_mocked)
      get :index, :query => "aaa##%##*##bbbb"
    end

    it "filters non allowed characters and if remaining string is NOT valid query should NOT call index_tank" do
      SearchController::should_receive(:index_tank).exactly(0).times()
      get :index, :query => '%##*#?'
    end
  end


end
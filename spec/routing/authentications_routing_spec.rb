require "spec_helper"

describe AuthenticationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/authentications" }.should route_to(:controller => "authentications", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/authentications/new" }.should route_to(:controller => "authentications", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/authentications/1" }.should route_to(:controller => "authentications", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/authentications/1/edit" }.should route_to(:controller => "authentications", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/authentications" }.should route_to(:controller => "authentications", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/authentications/1" }.should route_to(:controller => "authentications", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/authentications/1" }.should route_to(:controller => "authentications", :action => "destroy", :id => "1")
    end

  end
end

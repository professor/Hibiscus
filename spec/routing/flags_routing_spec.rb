require "spec_helper"

describe FlagsController do
  describe "routing" do

    it "routes to #index" do
      get("/flags").should route_to("flags#index")
    end

    it "routes to #new" do
      get("/flags/new").should route_to("flags#new")
    end

    it "routes to #show" do
      get("/flags/1").should route_to("flags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/flags/1/edit").should route_to("flags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/flags").should route_to("flags#create")
    end

    it "routes to #update" do
      put("/flags/1").should route_to("flags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/flags/1").should route_to("flags#destroy", :id => "1")
    end

  end
end

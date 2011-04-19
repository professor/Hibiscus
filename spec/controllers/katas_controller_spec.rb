require 'spec_helper'

describe KatasController do

  def mock_kata(stubs = {})
    @mock_kata ||= mock_model(Kata, stubs).as_null_object
  end

  context "Unauthenticated user: " do
    it "should not allow access to 'new'" do
      get :new
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to create a kata" do
      post :create
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should allow access to view a kata" do
      Kata.should_receive(:find).and_return(mock_kata)
      get :show, :id => mock_kata.id
      assigns(:kata).should == mock_kata
      response.should be_success
    end
  end

  context "Authenticated user: " do
    before(:each) do
      login
    end
    
    describe "GET new" do
      it "should make a new kata" do
        Kata.should_receive(:new)
        get :new
      end
    end
    
    describe "POST create" do
      it "should set a successful flash message and redirect to the user's page upon successful creation of a kata" do
        post :create, :kata => { :title => "Kata", :instructions => "Some instructions." }
        flash[:notice].should == "Kata successfully created."
        response.should redirect_to(root_url)
      end
      
      it "should set a failure flash message and redirect to the user's page upon failed creation of a kata" do
        post :create, :kata => { }
        flash[:alert].should == "Kata could not be saved."
        response.should redirect_to(root_url)
      end
    end
  end
end

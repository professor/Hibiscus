require 'spec_helper'

describe PlansController do

  def mock_plan(stubs = {})
    @mock_plan ||= mock_model(Plan, stubs).as_null_object
  end
  
  def mock_user(stubs = {})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  context "Unauthenticated user: " do
    it "should not allow access to create a plan" do
      post :create, :user_id => '1'
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to edit a plan" do
      get :edit, :user_id => 1, :id => mock_plan.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to update a plan" do
      put :update, :user_id => 1, :id => mock_plan.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
  end

  context "Authenticated user: " do
    before(:each) do
      login
    end
    
    describe "POST create" do
      it "should set a successful flash message and redirect to the user's page after creating a plan" do
        post :create, :user_id => @user.id, :plan => { :maiden_speech => "Some speech." }
        flash[:notice].should == "Thank you for creating your learning plan."
        response.should redirect_to(@user)
      end
      
      it "should set a failure flash message and redirect to the user's page after failing to save a plan" do
        Plan.should_receive(:new).and_return(mock_plan(:save => false))
        mock_plan.stub(:user).and_return(@user)
        post :create, :user_id => @user.id, :plan => {}
        flash[:alert].should == "Your learning plan could not be saved."
        response.should redirect_to(@user)
      end
      
      it "should set a failure flash message and redirect to the user's page if the user already has a plan" do
        controller.current_user.stub(:plan).and_return(mock_plan)
        post :create, :user_id => @user.id, :plan => {}
        flash[:alert].should == "You already have a learning plan."
        response.should redirect_to(@user)
      end
    end
    
    describe 'GET edit' do
      it "should set the current user as user and his learning plan as plan" do
        get :edit, :user_id => @user.id, :id => mock_plan.id
        assigns[:user].should == @user
        assigns[:plan].should == @user.plan
      end
    end
    
    describe 'PUT update' do
      it "should set the current user as user and his learning plan as plan" do
        controller.current_user.stub(:plan).and_return(mock_plan)
        put :update, :user_id => @user.id, :id => mock_plan.id
        assigns[:user].should == controller.current_user
        assigns[:plan].should == controller.current_user.plan
      end
      
      it "should set a successful flash message and redirect to the user's page after updating a learning plan" do
        controller.current_user.stub(:plan).and_return(mock_plan)
        mock_plan.should_receive(:update_attributes).and_return(true)
        put :update, :user_id => @user.id, :id => mock_plan.id
        flash[:notice].should == "Thank you for updating your learning plan."
        response.should redirect_to(@user)
      end
      
      it "should render the edit template when a learning plan failed to update" do
        controller.current_user.stub(:plan).and_return(mock_plan)
        mock_plan.should_receive(:update_attributes).and_return(false)
        put :update, :user_id => @user.id, :id => mock_plan.id
        response.should render_template("edit")
      end
    end
  end
end

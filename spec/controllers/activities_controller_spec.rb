require 'spec_helper'

describe ActivitiesController do

  def mock_activity(stubs = {})
    @mock_activity ||= mock_model(Activity, stubs).as_null_object
  end
  
  def mock_plan(stubs = {})
    @mock_plan ||= mock_model(Plan, stubs).as_null_object
  end

  context "Unauthenticated user: " do
    it "should not allow access to create an activity" do
      post :create, :user_id => 1, :plan_id => 1
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    # it "should not allow access to edit an activity" do
    #   get :edit, :user_id => 1, :plan_id => 1, :id => mock_activity.id
    #   flash[:alert].should == "You need to sign in before continuing."
    #   response.should redirect_to("/users/sign_in")
    # end
    # 
    # it "should not allow access to update an activity" do
    #   put :update, :user_id => 1, :plan_id => 1, :id => mock_activity.id
    #   flash[:alert].should == "You need to sign in before continuing."
    #   response.should redirect_to("/users/sign_in")
    # end
    # 
    # it "should not allow access to update an activity" do
    #   delete :destroy, :user_id => 1, :plan_id => 1, :id => mock_activity.id
    #   flash[:alert].should == "You need to sign in before continuing."
    #   response.should redirect_to("/users/sign_in")
    # end
  end

  context "Authenticated user: " do
    before(:each) do
      login
    end
    
    describe "POST create" do
      it "should set a successful flash message and redirect to the user's page upon successful creation of an activity" do
        controller.current_user.stub(:plan).and_return(mock_plan)
        post :create, :user_id => @user.id, :plan_id => mock_plan.id, :activity => { :name => "Some activity." }
        flash[:notice].should == "Activity successfully created."
        response.should redirect_to(@user)
      end
      
      it "should set a failure flash message and redirect to the user's page upon failed creation of an activity" do
        controller.current_user.stub(:plan).and_return(mock_plan)
        mock_plan.activities.should_receive(:build).and_return(mock_activity(:save => false))
        post :create, :user_id => @user.id, :plan_id => mock_plan.id, :activity => { }
        flash[:alert].should == "Activity could not be saved."
        response.should redirect_to(@user)
      end
    end
  end
end

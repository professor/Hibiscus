require 'spec_helper'

describe AchievementsController do

  def mock_achievement(stubs = {})
    @mock_achievement ||= mock_model(Achievement, stubs).as_null_object
  end

  context "Unauthenticated user: " do
    it "should allow access to index" do
      get :index
      response.should be_success
    end

    it "should allow access to show an achievement" do
      Achievement.should_receive(:find).and_return(mock_achievement)
      get :show, :id => mock_achievement.id
      response.should be_success
    end

    it "should not allow access to make a new achievement" do
      get :new
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to create an achievement" do
      post :create
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to edit an achievement" do
      get :edit, :id => mock_achievement.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to update an achievement" do
      put :update, :id => mock_achievement.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
  end

  context "Authenticated user: " do
    before(:each) do
      login
    end

    describe "GET index" do
      it "assigns all posts as @posts" do
        Achievement.stub(:all) { [mock_achievement] }
        get :index
        assigns(:achievements).should eq([mock_achievement])
      end
    end

    describe "GET show" do
      it "assigns the requested post as @post" do
        Achievement.stub(:find).with("37") { mock_achievement }
        get :show, :id => "37"
        assigns(:achievement).should be(mock_achievement)
      end
    end

    describe "GET new" do
      it "assigns a new post as @post" do
        Achievement.stub(:new) { mock_achievement }
        get :new
        assigns(:achievement).should be(mock_achievement)
      end
    end

    describe "GET edit" do
      it "assigns the requested post as @post" do
        Achievement.stub(:find).with("37") { mock_achievement }
        get :edit, :id => "37"
        assigns(:achievement).should be(mock_achievement)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "assigns a newly created post as @post" do
          Achievement.stub(:new).with({'these' => 'params'}) { mock_achievement(:save => true) }
          post :create, :achievement => {'these' => 'params'}
          assigns(:achievement).should be(mock_achievement)
        end

        it "redirects to the index" do
          Achievement.stub(:new) { mock_achievement(:save => true) }
          post :create, :achievement => {}
          response.should redirect_to(achievements_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved post as @post" do
          Achievement.stub(:new).with({'these' => 'params'}) { mock_achievement(:save => false) }
          post :create, :achievement => {'these' => 'params'}
          assigns(:achievement).should be(mock_achievement)
        end

        it "re-renders the 'new' template" do
          Achievement.stub(:new) { mock_achievement(:save => false) }
          post :create, :achievement => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested post" do
          Achievement.stub(:find).with("37") { mock_achievement }
          mock_achievement.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :achievement => {'these' => 'params'}
        end

        it "assigns the requested post as @post" do
          Achievement.stub(:find) { mock_achievement(:update_attributes => true) }
          put :update, :id => "1"
          assigns(:achievement).should be(mock_achievement)
        end

        it "redirects to the index" do
          Achievement.stub(:find) { mock_achievement(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(achievements_url)
        end
      end

      describe "with invalid params" do
        it "assigns the post as @post" do
          Achievement.stub(:find) { mock_achievement(:update_attributes => false) }
          put :update, :id => "1"
          assigns(:achievement).should be(mock_achievement)
        end

        it "re-renders the 'edit' template" do
          Achievement.stub(:find) { mock_achievement(:update_attributes => false) }
          put :update, :id => "1"
          response.should render_template("edit")
        end
      end
    end

  end
end

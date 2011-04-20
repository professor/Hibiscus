require 'spec_helper'

describe KatacommentsController do

  def mock_post(stubs = {})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end
  
  def mock_katacomment(stubs = {})
    @mock_katacomment ||= mock_model(Katacomment, stubs).as_null_object
  end
  
  context "Unauthenticated user: " do    
    it "should not allow access to create a katacomment" do
      post :create, :post_id => mock_post.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to edit a katacomment" do
      get :edit, :post_id => mock_post.id, :id => mock_katacomment.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to update a katacomment" do
      put :update, :post_id => mock_post.id, :id => mock_katacomment.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
  end
  
  context "Authenticated user: " do
    before(:each) do
      login
    end

    describe "POST create" do
      context "with valid params" do
        before(:each) do
          Post.stub(:find).and_return(mock_post)
          post :create, :post_id => mock_post.id, :katacomment => { :content => 'Some content.' }
        end

        it 'sets the flash notice' do
          flash[:notice].should == 'Thank you for your Kata feedback.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(post_url(mock_post))
        end
      end
    
      context "with invalid params" do
        before(:each) do
          Post.stub(:find).and_return(mock_post)
          mock_post.katacomments.stub(:build) { mock_katacomment(:save => false) }
          post :create, :post_id => mock_post.id, :katacomment => { }
        end

        it 'sets the flash alert' do
          flash[:alert].should == 'Your Kata feedback could not be saved.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(post_url(mock_post))
        end
      end
    end
  
    describe "GET edit" do
      it "assigns the requested katacomment as @katacomment, and it's parent post as @post" do
        Post.should_receive(:find).and_return(mock_post)
        mock_post.should_receive(:katacomments).and_return(mock_katacomment)
        get :edit, :post_id => mock_post.id, :id => mock_katacomment.id
        assigns(:post).should be(mock_post)
        assigns(:katacomment).should be(mock_katacomment)
      end
    end
  
    describe "PUT update" do
      context "with valid params" do
        it "should set a successful flash message, then redirect to the parent post" do
          Post.should_receive(:find).and_return(mock_post)
          mock_post.should_receive(:katacomments).and_return(mock_katacomment(:update_attributes => true))
          put :update, :post_id => mock_post.id, :id => mock_katacomment.id
          assigns(:post).should be(mock_post)
          assigns(:katacomment).should be(mock_katacomment)
          flash[:notice].should == "Thank you for the update in your Kata feedback."
          response.should redirect_to(mock_post)
        end
      end
    
      context "with invalid params" do
        it "assigns the requested katacomment as @katacomment, and it's parent post as @post" do
          Post.should_receive(:find).and_return(mock_post)
          mock_post.should_receive(:katacomments).and_return(mock_katacomment(:update_attributes => false))
          put :update, :post_id => mock_post.id, :id => mock_katacomment.id
          assigns(:post).should be(mock_post)
          assigns(:katacomment).should be(mock_katacomment)
          response.should render_template("edit")
        end
      end
    end
  end
end

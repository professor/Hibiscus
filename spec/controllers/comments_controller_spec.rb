require 'spec_helper'

describe CommentsController do
  def mock_post(stubs = {})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end
  
  def mock_comment(stubs = {})
    @mock_comment ||= mock_model(Comment, stubs).as_null_object
  end
  
  context "Unauthenticated user: " do    
    it "should not allow access to create a comment" do
      post :create, :post_id => mock_post.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to edit a comment" do
      get :edit, :post_id => mock_post.id, :id => mock_comment.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to update a comment" do
      put :update, :post_id => mock_post.id, :id => mock_comment.id
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
          Post.stub(:find_by_slug).and_return(mock_post)
          mock_post.comments.stub(:build) { mock_comment }
          post :create, :post_id => mock_post.id, :comment => mock_comment
        end

        it 'sets the flash notice' do
          flash[:notice].should == 'Thank you for your comment.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(post_url(mock_post))
        end
      end
    
      context "with invalid params" do
        before(:each) do
          Post.stub(:find_by_slug).and_return(mock_post)
          mock_post.comments.stub(:build) { mock_comment(:save => false) }
          post :create, :post_id => mock_post.id, :comment => { }
        end

        it 'sets the flash alert' do
          flash[:alert].should == 'Your comment could not be saved.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(post_url(mock_post))
        end
      end
    end
  
    describe "GET edit" do
      it "assigns the requested comment as @comment, and it's parent post as @post" do
        Post.should_receive(:find_by_slug).and_return(mock_post)
        mock_post.should_receive(:comments).and_return(mock_comment)
        mock_comment.stub(:user_id) { controller.current_user.id }
        get :edit, :post_id => mock_post.id, :id => mock_comment.id
        assigns(:commentable).should be(mock_post)
        assigns(:comment).should be(mock_comment)
      end
    end
  
    describe "PUT update" do
      context "with valid params" do
        it "should set a successful flash message, then redirect to the parent post" do
          Post.should_receive(:find_by_slug).and_return(mock_post)
          mock_post.should_receive(:comments).and_return(mock_comment({:user_id => controller.current_user.id, :update_attributes => true}))
          put :update, :post_id => mock_post.id, :id => mock_comment.id
          assigns(:commentable).should be(mock_post)
          assigns(:comment).should be(mock_comment)
          flash[:notice].should == "Thank you for the update in your comment."
          response.should redirect_to(mock_post)
        end
      end
    
      context "with invalid params" do
        it "assigns the requested comment as @comment, and it's parent post as @post" do
          Post.should_receive(:find_by_slug).and_return(mock_post)
          mock_post.should_receive(:comments).and_return(mock_comment({:user_id => controller.current_user.id, :update_attributes => false}))
          put :update, :post_id => mock_post.id, :id => mock_comment.id
          assigns(:commentable).should be(mock_post)
          assigns(:comment).should be(mock_comment)
          response.should render_template("edit")
        end
      end  
    end

    describe "DELETE destroy the comment" do
      it "redirects to the post" do
        Post.stub(:find_by_slug) { mock_post }
        mock_post.stub(:user_id) { controller.current_user.id }
        delete :destroy, :id => "2", :post_id => 2
        response.should redirect_to(mock_post)
      end

      it "should correctly delete the comment " do
        Post.stub(:find_by_slug) { mock_post }
        mock_post.stub(:user) { controller.current_user }
        mock_post.stub_chain(:comments, :find) { mock_comment }
        mock_comment.stub(:user_id) { controller.current_user.id }
        mock_comment.should_receive(:destroy)
        delete :destroy, :id => mock_comment.id, :post_id => mock_post.id
      end
    end
  end
end

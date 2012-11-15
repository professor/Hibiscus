require 'spec_helper'

describe CommentsController do
  def mock_post(stubs = {})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end

  def mock_comment(stubs = {})
    @mock_comment ||= mock_model(Comment, stubs).as_null_object
  end


  def mock_kata(stubs = {})
    @mock_kata ||= mock_model(Kata, stubs).as_null_object
  end

  def mock_review(stubs = {})
    @mock_review ||= mock_model(Review, stubs).as_null_object
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
          post :create, :post_id => mock_post.id, :comment => {}
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
      it "assigns the requested comment as @comment, and it's parent post as @commentable" do
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
        it "assigns the requested comment as @comment, and it's parent post as @commentable" do
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

  context "Unauthenticated user: " do
    it "should not allow access to create a review" do
      post :create, :type => "Kata", :kata_id => mock_kata.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to edit a review" do
      get :edit, :type => "Kata", :kata_id => mock_kata.id, :id => mock_review.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to update a review" do
      put :update, :type => "Kata", :kata_id => mock_kata.id, :id => mock_review.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    it "should not allow access to delete a review" do
      delete :destroy, :type => "Kata", :kata_id => mock_kata.id, :id => mock_review.id
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
          Kata.stub(:find_by_slug).and_return(mock_kata)
          mock_kata.reviews.stub(:build) { mock_review }
          post :create, :type => "Kata", :kata_id => mock_kata.id, :review => mock_review
        end

        it 'sets the flash notice' do
          flash[:notice].should == 'Thank you for your review.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(kata_url(mock_kata))
        end
      end

      context "with invalid params" do
        before(:each) do
          Kata.stub(:find_by_slug).and_return(mock_kata)
          mock_kata.reviews.stub(:build) { mock_review(:save => false) }
          post :create, :type => "Kata", :kata_id => mock_kata.id, :review => {}
        end

        it 'sets the flash alert' do
          flash[:alert].should == 'Your review could not be saved.'
        end

        it 'redirects to the kata URL' do
          response.should redirect_to(kata_url(mock_kata))
        end
      end
    end

    describe "GET edit" do
      it "assigns the requested review as @comment, and it's parent kata as @commentable" do
        Kata.should_receive(:find_by_slug).and_return(mock_kata)
        mock_kata.should_receive(:reviews).and_return(mock_review)
        mock_review.stub(:user_id) { controller.current_user.id }
        get :edit, :type => "Kata", :kata_id => mock_kata.id, :id => mock_review.id
        assigns(:commentable).should be(mock_kata)
        assigns(:comment).should be(mock_review)
      end
    end

    describe "PUT update" do
      context "with valid params" do
        it "should set a successful flash message, then redirect to the parent kata" do
          Kata.should_receive(:find_by_slug).and_return(mock_kata)
          mock_kata.should_receive(:reviews).and_return(mock_review({:user_id => controller.current_user.id, :update_attributes => true}))
          put :update, :type => "Kata", :kata_id => mock_kata.id, :id => mock_review.id
          assigns(:commentable).should be(mock_kata)
          assigns(:comment).should be(mock_review)
          flash[:notice].should == "Thank you for the update in your review."
          response.should redirect_to(mock_kata)
        end
      end

      context "with invalid params" do
        it "assigns the requested review as @comment, and it's parent kata as @commentable" do
          Kata.should_receive(:find_by_slug).and_return(mock_kata)
          mock_kata.should_receive(:reviews).and_return(mock_review({:user_id => controller.current_user.id, :update_attributes => false}))
          put :update, :type => "Kata", :kata_id => mock_kata.id, :id => mock_review.id
          assigns(:commentable).should be(mock_kata)
          assigns(:comment).should be(mock_review)
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy the review" do
      it "redirects to the post" do
        Kata.stub(:find_by_slug) { mock_kata }
        mock_kata.stub(:user_id) { controller.current_user.id }
        delete :destroy, :type => "Kata", :id => "2", :kata_id => 2
        response.should redirect_to(mock_kata)
      end

      it "should correctly delete the review " do
        Kata.stub(:find_by_slug) { mock_kata }
        mock_kata.stub(:user) { controller.current_user }
        mock_kata.stub_chain(:reviews, :find) { mock_review }
        mock_review.stub(:user_id) { controller.current_user.id }
        mock_review.should_receive(:destroy)
        delete :destroy, :type => "Kata", :id => mock_review.id, :kata_id => mock_kata.id
      end
    end
  end
end

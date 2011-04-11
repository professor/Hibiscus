require 'spec_helper'

describe CommentsController do
  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end
  
  def mock_comment(stubs={})
    @mock_comment ||= mock_model(Comment, stubs).as_null_object
  end
  
  before(:each) do
    login
  end

  describe "POST create" do
    context "with valid params" do
      before(:each) do
        Post.stub(:find).and_return(mock_post)
        post :create, :post_id => mock_post.id, :comment => { :content => 'Some content.' }
      end

      it 'successfully creates a new comment' do
        # FIXME: NEED TO WRITE THIS.
        pending 'NEED TO WRITE THIS.'
        # puts @post.comments
        # @post.comments(true).length.should eq(1)
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
        Post.stub(:find).and_return(mock_post)
        mock_post.comments.stub(:build) { mock_comment(:save => false) }
        post :create, :post_id => mock_post.id, :comment => { }
      end

      it 'sets the flash error' do
        flash[:error].should == 'Your comment could not be saved.'
      end

      it 'redirects to the post URL' do
        response.should redirect_to(post_url(mock_post))
      end
    end
  end
  
  describe "GET edit" do
    it "assigns the requested comment as @comment, and it's parent post as @post" do
      Post.should_receive(:find).and_return(mock_post)
      mock_post.should_receive(:comments).and_return(mock_comment)
      # @post.comments.stub(:find).and_return(:)
      get :edit, :post_id => mock_post.id, :id => mock_comment.id
      assigns(:post).should be(mock_post)
      assigns(:comment).should be(mock_comment)
    end
  end
  
  describe "PUT update" do
    context "with valid params" do
      it "should set a successful flash message, then redirect to the parent post" do
        Post.should_receive(:find).and_return(mock_post)
        mock_post.should_receive(:comments).and_return(mock_comment(:update_attributes => true))
        put :update, :post_id => mock_post.id, :id => mock_comment.id
        assigns(:post).should be(mock_post)
        assigns(:comment).should be(mock_comment)
        flash[:notice].should == "Thank you for the update in your comment."
        response.should redirect_to(mock_post)
      end
    end
    
    context "with invalid params" do
      it "assigns the requested comment as @comment, and it's parent post as @post" do
        Post.should_receive(:find).and_return(mock_post)
        mock_post.should_receive(:comments).and_return(mock_comment(:update_attributes => false))
        put :update, :post_id => mock_post.id, :id => mock_comment.id
        assigns(:post).should be(mock_post)
        assigns(:comment).should be(mock_comment)
        response.should render_template("edit")
      end
    end
  end
end

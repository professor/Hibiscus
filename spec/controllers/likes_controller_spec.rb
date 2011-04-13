require 'spec_helper'

describe LikesController do
  def mock_post(stubs = {})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end
  
  context "Unauthenticated user: " do
    it "should not allow access to create a like" do
      post :create
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
          post :create, :like => { :post_id => mock_post.id }
        end
      
        it 'sets the flash notice' do
          flash[:notice].should == 'You liked this post.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(post_url(mock_post))
        end
      end
    
      context "with invalid params" do
        before(:each) do
          Post.stub(:find).and_return(mock_post)
          post :create, :like => {}
        end

        it 'sets the flash alert' do
          flash[:alert].should == 'Your like could not be recorded.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(post_url(mock_post))
        end
      end
    end
  end
end

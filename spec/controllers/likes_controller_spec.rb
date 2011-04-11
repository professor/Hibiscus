require 'spec_helper'

describe LikesController do
  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end
  
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

      it 'sets the flash error' do
        flash[:error].should == 'Your like could not be recorded.'
      end

      it 'redirects to the post URL' do
        response.should redirect_to(post_url(mock_post))
      end
    end
  end
end

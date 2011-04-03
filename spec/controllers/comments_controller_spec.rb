require 'spec_helper'

describe CommentsController do
  before(:each) do
    @post = Factory(:post)
  end

  describe "POST create" do
    context "with valid params" do
      before { post :create, :post_id => @post.id, :comment => { :content => 'Some content.' } }

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
        response.should redirect_to(post_url(@post))
      end
    end
    
    context "with invalid params" do
      before { post :create, :post_id => @post.id, :comment => {} }

      it 'sets the flash error' do
        flash[:error].should == 'Your comment could not be saved.'
      end

      it 'redirects to the post URL' do
        response.should redirect_to(post_url(@post))
      end
    end
  end
  
  describe "GET edit" do

  end
end

require 'spec_helper'

describe FlagsController do

  def mock_post(stubs = {})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end

  context "Unauthenticated user: " do
    it "should not allow access to create a flag" do
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
          @post = FactoryGirl.create(:post)
          post :create, :post_type => "Post", :post_id => @post.id
        end

        it 'sets the flash notice' do
          flash[:notice].should == 'You reported this content.'
        end

        it 'redirects to the post URL' do
          response.should redirect_to(post_url(@post))
        end
      end

      context "with invalid params" do
        before(:each) do
          post :create
        end

        it 'sets the flash alert' do
          flash[:alert].should include ("Your report could not be recorded.")
        end

        it 'redirects to the root URL' do
          response.should redirect_to(root_path)
        end
      end
    end
  end
end

require 'spec_helper'

describe ActsAsVoter do

  describe "test instance methods" do

    describe "Greg voted for (upvoted) the review" do

      before(:each) do
        @user_for = FactoryGirl.build(:user, name: "Good Guy Greg")
        @review = FactoryGirl.build(:review)
        @user_for.vote_for(@review)
      end

      it "is true that Greg voted for the review" do
        @user_for.should be_voted_for(@review)
      end

      it "is true that Greg voted on the review" do
        @user_for.should be_voted_on(@review)
      end

      it "is true that Greg voted for (upvoted) the review once" do
        @user_for.vote_score.should be 1
        @user_for.vote_score(:up).should be 1
        @user_for.vote_score(:down).should be 0
        @user_for.voted_which_way?(@review, :up).should be true
        @user_for.voted_which_way?(@review, :down).should be false
      end

      it "is true that Greg voted only once till now, and it's on a review" do
        @user_for.votes.where(:voteable_type => 'Review').count.should be 1
        @user_for.votes.where(:voteable_type => 'Kata').count.should be 0
      end

      it "is allowed for Greg to suddenly change his mind to make an opposite vote" do
        @user_for.vote_exclusively_against(@review)
        @user_for.should be_voted_against(@review)
      end

      it "is allowed for Greg to unvote" do
        @user_for.unvote_for(@review)
        @user_for.vote_score.should be 0
      end

      it "raises ArgumentError for arguments that are not up or down" do
        expect { @user_for.voted_which_way?(@review, :upsidedown) }.to raise_error(ArgumentError)
        expect { @user_for.vote(@review, {:direction => :insideout}) }.to raise_error(ArgumentError)
      end

    end

    describe "Steve voted against (downvoted) the review" do

      before(:each) do
        @user_against = FactoryGirl.build(:user, name: "Scumbag Steve")
        @review = FactoryGirl.build(:review)
        @user_against.vote_against(@review)
      end

      it "is true that Steve voted against the review" do
        @user_against.should be_voted_against(@review)
      end

      it "is true that Steve voted on the review" do
        @user_against.should be_voted_on(@review)
      end

      it "is true that Steve voted against (upvoted) the review once" do
        @user_against.vote_score.should be 1
        @user_against.vote_score(:up).should be 0
        @user_against.vote_score(:down).should be 1
        @user_against.voted_which_way?(@review, :up).should be false
        @user_against.voted_which_way?(@review, :down).should be true
      end

      it "is true that Steve voted only once till now, and it's on a review" do
        @user_against.votes.where(:voteable_type => 'Review').count.should be 1
        @user_against.votes.where(:voteable_type => 'Kata').count.should be 0
      end

      it "is allowed for Steve to suddenly change his mind to make an opposite vote" do
        @user_against.vote_exclusively_for(@review)
        @user_against.should be_voted_for(@review)
      end

      it "is allowed for Steve to unvote" do
        @user_against.unvote_for(@review)
        @user_against.vote_score.should be 0
      end

      it "raises ArgumentError for arguments that are not up or down" do
        expect { @user_against.voted_which_way?(@review, :upsidedown) }.to raise_error(ArgumentError)
      end

    end

  end

end

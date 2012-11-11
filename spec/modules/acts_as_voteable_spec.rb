require 'spec_helper'

describe ActsAsVoteable do

  describe "test instance methods" do

    describe "Greg and Lucifer voted for (upvoted) the review" do

      before(:each) do
        @user_1_for = FactoryGirl.build(:user, name: "Good Guy Greg")
        @user_2_for = FactoryGirl.build(:user, name: "Good Guy Lucifer")
        @review = FactoryGirl.build(:review)
        @user_1_for.vote_for(@review)
        @user_2_for.vote_for(@review)
      end

      it "got two upvotes" do
        @review.votes_for.should be 2
      end

      it "got zero downvotes" do
        @review.votes_against.should be 0
      end

      it "has a vote score of two" do
        @review.plusminus.should be 2
      end

      describe "And then Steve showed up and voted against the review" do
        before(:each) do
          @user_against = FactoryGirl.build(:user, name: "Scumbag Steve")
          @user_against.vote_against(@review)
        end

        it "has one downvote now" do
          @review.votes_against.should be 1
        end

        it "has a vote score of 1" do
          @review.plusminus.should be 1
        end

        it "has three votes in total" do
          @review.votes_count.should be 3
        end

        it "has a percentage of 67 for upvotes" do
          @review.percent_for.should be 67
          @review.percent_against.should be 33
        end

        it "was voted by Greg, Lucifer and Steve" do
          non_voter = FactoryGirl.build(:user, name:"Bad Luck Brain")
          @review.should be_voted_by(@user_1_for)
          @review.should be_voted_by(@user_2_for)
          @review.should be_voted_by(@user_against)
          @review.should_not be_voted_by(non_voter)
        end

      end

    end

  end

end

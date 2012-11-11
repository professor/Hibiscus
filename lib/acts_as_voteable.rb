# The module to be included to let the subject act as a voteable (object that voters can vote on).
# This module is supposed to work in pair with the other module 'ActsAsVoter'.
# Code adapted from https://github.com/bouchard/thumbs_up/
# Usage of the module can be found in
# https://github.com/bouchard/thumbs_up/
# and
# http://stackoverflow.com/questions/4907744/clarification-on-how-to-use-thumbs-up-voting-gem-with-rails-3

module ActsAsVoteable

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_voteable
      has_many :votes, :as => :voteable, :dependent => :destroy

      include ActsAsVoteable::InstanceMethods
      extend ActsAsVoteable::SingletonMethods
    end
  end

  # Irrelevant methods were removed in this module for this application.
  # More methods on: https://github.com/bouchard/thumbs_up/blob/master/lib/acts_as_voteable.rb
  module SingletonMethods
    # Removed:
    # plusminus_tally(params = {})
    # tally(*args)
    # column_names_for_tally
  end

  module InstanceMethods

    def votes_for
      self.votes.where(:vote => true).count
    end

    def votes_against
      self.votes.where(:vote => false).count
    end

    # Return the percentage of upvotes in all votes
    def percent_for
      (votes_for.to_f * 100 / (self.votes.size + 0.0001)).round
    end

    # Return the percentage of downvotes in all votes
    def percent_against
      (votes_against.to_f * 100 / (self.votes.size + 0.0001)).round
    end

    # You'll probably want to use this method to display how 'good' a particular voteable
    # is, and/or sort based on it.
    # If you're using this for a lot of voteables, then you'd best use the #plusminus_tally
    # method above.
    def plusminus
      respond_to?(:plusminus_tally) ? plusminus_tally : (votes_for - votes_against)
    end

    # The lower bound of a Wilson Score with a default confidence interval of 95%. Gives a more accurate representation of average rating (plusminus) based on the number of positive ratings and total ratings.
    # http://evanmiller.org/how-not-to-sort-by-average-rating.html
    def ci_plusminus(confidence = 0.95)
      require 'statistics2'
      n = votes.size
      if n == 0
        return 0
      end
      z = Statistics2.pnormaldist(1 - (1 - confidence) / 2)
      phat = 1.0 * votes_for / n
      (phat + z * z / (2 * n) - z * Math.sqrt((phat * (1 - phat) + z * z / (4 * n)) / n)) / (1 + z * z / n)
    end

    # Return the number of votes on this voteable
    def votes_count
      votes.size
    end

    # Return all the voters who voted for this voteable
    def voters_who_voted
      votes.map(&:voter).uniq
    end

    # Check if a specific voter has voted for this voteable
    def voted_by?(voter)
      0 < Vote.where(
          :voteable_id => self.id,
          :voteable_type => self.class.name,
          :voter_id => voter.id
      ).count
    end

  end
end
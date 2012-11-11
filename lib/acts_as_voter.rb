# The module to be included to let the subject act as a voter.
# This module is supposed to work in pair with the other module 'ActsAsVoteable'.
# Code adapted from https://github.com/bouchard/thumbs_up/
# Usage of the module can be found in
# https://github.com/bouchard/thumbs_up/
# and
# http://stackoverflow.com/questions/4907744/clarification-on-how-to-use-thumbs-up-voting-gem-with-rails-3

module ActsAsVoter

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_voter

      # If a voting entity is deleted, keep the votes.
      # If you want to nullify (and keep the votes), you'll need to remove
      # the unique constraint on the [ voter, voteable ] index in the database.
      # has_many :votes, :as => :voter, :dependent => :nullify
      # Destroy votes when a user is deleted.
      has_many :votes, :as => :voter, :dependent => :destroy

      include ActsAsVoter::InstanceMethods
      extend ActsAsVoter::SingletonMethods
    end
  end

  # This module contains class methods
  module SingletonMethods
  end

  # This module contains instance methods
  module InstanceMethods

    # Get the vote history of this voter
    # Usage user.vote_score(:up)  # All +1 votes
    #       user.vote_score(:down) # All -1 votes
    #       user.vote_score()      # All votes
    def vote_score(for_or_against = :all)
      v = Vote.where(:voter_id => id).where(:voter_type => self.class.name)
      v = case for_or_against
            when :all then
              v
            when :up then
              v.where(:vote => true)
            when :down then
              v.where(:vote => false)
          end
      v.count
    end

    def voted_for?(voteable)
      voted_which_way?(voteable, :up)
    end

    def voted_against?(voteable)
      voted_which_way?(voteable, :down)
    end

    # Check if the voter voted on this voteable. (Can be either voted for or voted against)
    def voted_on?(voteable)
      0 < Vote.where(
          :voter_id => self.id,
          :voter_type => self.class.name,
          :voteable_id => voteable.id,
          :voteable_type => voteable.class.name
      ).count
    end

    def vote_for(voteable)
      self.vote(voteable, {:direction => :up, :exclusive => false})
    end

    def vote_against(voteable)
      self.vote(voteable, {:direction => :down, :exclusive => false})
    end

    def vote_exclusively_for(voteable)
      self.vote(voteable, {:direction => :up, :exclusive => true})
    end

    def vote_exclusively_against(voteable)
      self.vote(voteable, {:direction => :down, :exclusive => true})
    end

    # Vote on a specific voteable.
    # Must specify the voteable
    # Must specify the direction of vote {:direction => :down} or {:direction => :up}
    # Optional to specify if this vote is exclusive. That is, on this specific voteable,
    # cancel previous votes from this user and only record this vote.
    def vote(voteable, options = {})
      raise ArgumentError, "you must specify :up or :down in order to vote" unless options[:direction] && [:up, :down].include?(options[:direction].to_sym)
      if options[:exclusive]
        self.unvote_for(voteable)
      end
      direction = (options[:direction].to_sym == :up)
      if voted_on?(voteable)
        unvote_for(voteable)
      else
        Vote.create!(:vote => direction, :voteable => voteable, :voter => self)
      end
    end

    # Cancel the voter's vote on a specific voteable
    def unvote_for(voteable)
      Vote.where(
          :voter_id => self.id,
          :voter_type => self.class.name,
          :voteable_id => voteable.id,
          :voteable_type => voteable.class.name
      ).map(&:destroy)
    end

    alias_method :clear_votes, :unvote_for

    # Check if the voter voted up/down on a specific voteable
    def voted_which_way?(voteable, direction)
      raise ArgumentError, "expected :up or :down" unless [:up, :down].include?(direction)
      0 < Vote.where(
          :voter_id => self.id,
          :voter_type => self.class.name,
          :vote => direction == :up ? true : false,
          :voteable_id => voteable.id,
          :voteable_type => voteable.class.name
      ).count
    end

  end
end
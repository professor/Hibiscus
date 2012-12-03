# This model is used to record the votes that voteables receive.
# In this project, the current voter is user. The current voteables are posts/articles, comments(belongs to
# posts), and reviews(belongs to katas).
# By default, only one vote is allowed on a voteable per voter.
# Code adapted from https://github.com/bouchard/thumbs_up/
# Usage of voteable mechanism can be found in /lib/acts_as_voteable.rb and /lib/acts_as_voter.rb

class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true

  attr_accessible :vote, :voter, :voteable

  # Comment out the line below to allow multiple votes per user.
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

end
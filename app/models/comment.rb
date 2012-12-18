#Comment is embedded in Post model and it is used to store the comments of the users

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsVoteable

  acts_as_voteable

  field :content, :type => String
  field :time_spent, :type => String
  field :deleted_at, :type => Date
  field :vote_score, :type => Integer, default: 0

  embedded_in :post, :inverse_of => :comments
  references_many :flags, :dependent => :destroy
  referenced_in :user

  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :time_spent, :numericality => true, :allow_blank => true, :allow_nil => true

  def destroy
    write_attribute :deleted_at, Time.now
    save
  end

  #adds or substract the vote to the review
  def update_vote_score
    self.vote_score = self.plusminus
    save
  end

end

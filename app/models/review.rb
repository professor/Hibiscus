#The Review model contains the evaluation a user do about a Kata. Reviews are embedded in the Kata collection.

class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsVoteable

  after_save :calculate_kata_rating
  after_destroy :calculate_kata_rating
  after_update :calculate_kata_rating

  acts_as_voteable

  field :title, :type => String
  field :content, :type => String
  field :rating, :type => Float
  field :challenge_level, :type => String
  field :language, :type => String
  field :deleted_at, :type => Date
  field :vote_score, :type => Integer, default: 0

  has_and_belongs_to_many :categories

  attr_reader :category_tokens

  #method needed to process the string coming from tokenized input
  def category_tokens=(ids)
    self.category_ids = ids.split(",")
  end

  embedded_in :kata, :inverse_of => :reviews
  references_many :flags, :dependent => :destroy
  referenced_in :user

  validates :user_id, :presence => true
  validates :rating, :presence => true, :numericality => true

  ##
  # Calculate the rating of this review's Kata, and save the Kata with the calculated rating.
  def calculate_kata_rating
    reviews_ratings = 0

    if kata.reviews.count > 0
      kata.reviews.count.times do |i|
        reviews_ratings += kata.reviews.at(i).rating
      end
      kata.rating = reviews_ratings / kata.reviews.count
    else
      kata.rating = 0
    end
    kata.save
  end

  def destroy
    write_attribute :deleted_at, Time.now
    save
  end

  # Return the float count of the update time. The is used for a workaround for
  # mongoid time sorting bug: To sort by update time use the return value of this
  # method.
  def last_update
    self.updated_at.to_f
  end

  #adds or substract the vote to the review
  def update_vote_score
    self.vote_score = self.plusminus
    save
  end

  # Parse the updated_at field to Time type if it is a String
  def updated_at
    update_time = self[:updated_at]
    update_time = Time.parse(update_time) if update_time.is_a? String
    update_time
  end

  # Parse the created_at field to Time type if it is a String
  def created_at
    created_time = self[:created_at]
    created_time = Time.parse(created_time) if created_time.is_a? String
    created_time
  end
end

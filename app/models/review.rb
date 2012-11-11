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

  def category_tokens=(ids)
    self.category_ids = ids.split(",")
  end

  referenced_in :user
  embedded_in :kata, :inverse_of => :reviews

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :rating, :presence => true, :numericality => true

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

  def update_vote_score
    self.vote_score = self.plusminus
    save
  end
end

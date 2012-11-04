class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  after_save :add_to_kata_rating
  after_destroy :remove_from_kata_rating
  before_update :add_to_kata_rating
  after_update :remove_from_kata_rating

  field :title, :type => String
  field :content, :type => String
  field :rating, :type => Float
  field :challenge_level, :type => String
  field :language, :type => String
  field :upvoters, :type => Hash
  field :downvoters, :type => Hash

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

  def add_to_kata_rating
    kata.rating = ((kata.rating * (kata.reviews.count - 1)) + rating) / kata.reviews.count
    kata.save
  end

  def remove_from_kata_rating
    if kata.reviews.count > 0
      kata.rating = ((kata.rating * (kata.reviews.count + 1)) - rating) / kata.reviews.count
    else
      kata.rating = 0
    end
      kata.save
  end
end

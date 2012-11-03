class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  after_save :add_to_kata_rating
  after_destroy :remove_from_kata_rating

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
    self.kata.rating = ((self.kata.rating * (self.kata.reviews.count - 1)) + self.rating) / self.kata.reviews.count
    self.kata.save
  end

  def remove_from_kata_rating
    if self.kata.reviews.count > 0
      self.kata.rating = ((self.kata.rating * (self.kata.reviews.count + 1)) - self.rating) / self.kata.reviews.count
    else
      self.kata.rating = 0
    end
    self.kata.save
  end
end

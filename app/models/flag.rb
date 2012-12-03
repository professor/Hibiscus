# Flag is the model for content flags. A Flag instance is created when a user reports
# a Kata, Post, Comment, or Review. A Flag instance may reference one and only one
# of the four types of content.

class Flag
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :post
  referenced_in :kata, :class_name => "Kata"
  referenced_in :comment
  referenced_in :review
  referenced_in :user


  validate :must_have_a_resource
  validates :user_id, :presence => true, :uniqueness => {:scope => [:post_id, :kata_id, :comment_id, :review_id]}

  # Validation method to check that a Flag instance references one and only one
  # of the four types of content: Kata, Post, Comment, or Review.
  def must_have_a_resource
    if (post_id.blank? && kata_id.blank? && comment_id.blank? && review_id.blank?)
      errors[:base] << ("resource ID can't be nil.")
    end
  end

  # Getter method for the comment referenced by a Flag instance. It is declared explicitly
  # because since Comment is an embedded model, the referenced_in relation does not create
  # a getter method automatically.
  def comment
    comments = []

    if self.comment_id
      posts = Post.all
      posts.each do |p|
        comments = p.comments.where(_id: self.comment_id.to_s)
        break if comments.any?
      end
    end
    return comments.first
  end

  # Getter method for the review referenced by a Flag instance. It is declared explicitly
  # because since Review is an embedded model, the referenced_in relation does not create
  # a getter method automatically.
  def review
    reviews = []

    if self.review_id
      katas = Kata.all
      katas.each do |k|
        reviews = k.reviews.where(_id: self.review_id.to_s)
        break if reviews.any?
      end
    end
    return reviews.first
  end

end
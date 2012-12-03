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

  def must_have_a_resource
    if (post_id.blank? && kata_id.blank? && comment_id.blank? && review_id.blank?)
      errors[:base] << ("resource ID can't be nil.")
    end
  end

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
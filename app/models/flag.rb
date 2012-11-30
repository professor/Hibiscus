class Flag
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :post
  #referenced_in :article
  referenced_in :kata, :class_name => "Kata"
  referenced_in :comment
  referenced_in :review
  referenced_in :user


  #validates :post_id, :presence => true, :unless => :kata_id? || :comment_id? || :review_id?
  validate :must_have_a_resource
  validates :user_id, :presence => true, :uniqueness => {:scope => [:post_id, :kata_id, :comment_id, :review_id]}

  def must_have_a_resource
    unless (:post_id? || :kata_id? || :comment_id? || :review_id?)
      errors[:base] << ("resource ID can't be nil.")
    end
  end

  def content
    if self.post
      self.post
    elsif self.kata
      self.kata
    elsif self.comment_id
      self.comment.post
    elsif self.review_id
      self.review.kata
    end
  end

  def comment
    comment = nil

    if self.comment_id
      posts = Post.all
      posts.each do |p|
        comment = p.comments.where(_id: self.comment_id.to_s).first
        break if comment
      end
    end
    return comment
  end

  def review
    #review = nil
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
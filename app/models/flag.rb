class Flag
  include Mongoid::Document

  referenced_in :post
  #referenced_in :article
  referenced_in :kata, :class_name => "Kata"
  referenced_in :comment
  referenced_in :review
  referenced_in :user


  validates :post_id, :presence => true, :unless => :kata_id? || :comment_id? || :review_id?
  #validate :must_have_a_resource
  validates :user_id, :presence => true, :uniqueness => { :scope => [:post_id, :kata_id, :comment_id, :review_id] }

  #def must_have_a_resource
  #  unless (:post_id? || :kata_id? || :comment_id? || :review_id?)
  #    errors[:base] << ("resource ID can't be nil.")
  #  end
  #end
end
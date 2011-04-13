class Like
  include Mongoid::Document
  
  referenced_in :post
  referenced_in :user
  
  validates :post_id, :presence => true
  validates :user_id, :presence => true, :uniqueness => { :scope => :post_id }
end

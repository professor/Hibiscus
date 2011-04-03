class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :content, :type => String
  
  embedded_in :post, :opposite => :comments
  referenced_in :user
  
  validates :content, :presence => true
  validates :user_id, :presence => true
end

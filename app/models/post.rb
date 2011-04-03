class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :type => String
  field :content, :type => String
  
  embeds_many :comments
  references_many :likes, :dependent => :destroy
  referenced_in :user
  
  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
end

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  #paranoia module allows to implement "soft deletion"
  include Mongoid::Paranoia

  field :content, :type => String
  field :time_spent, :type => String

  embedded_in :post, :inverse_of => :comments
  referenced_in :user

  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :time_spent, :numericality => true, :allow_blank => true, :allow_nil => true
end

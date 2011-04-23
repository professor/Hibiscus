class Katacomment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :post, :opposite => :katacomments
  referenced_in :user

  validates :user_id, :presence => true
  
  field :recommendation, :type => String
  field :timeSpent, :type => String
  field :good, :type => String
  field :bad, :type => String
  field :language, :type => String
  field :ahhah, :type => String
end
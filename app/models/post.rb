class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :type => String
  field :content, :type => String
  field :isKata, :type => Boolean, :default => false
  
  key :title

  embeds_many :comments
  embeds_many :katacomments
  references_many :likes, :dependent => :destroy
  referenced_in :user

  validates :title, :presence => true
  validates :content, :presence => true
  validates :isKata, :inclusion => [true, false]
  validates :user_id, :presence => true
  
  def listLikes
    likes = []
    self.likes.each do |l|
      likes << l unless l.isDislike
    end
    
    return likes
  end
  
  def listDislikes
    dislikes = []
    self.likes.each do |l|
      dislikes << l if l.isDislike
    end
    
    return dislikes
  end
end

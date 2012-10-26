class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :content, :type => String
  field :rating, :type => Float
  field :challenge_level, :type => String
  field :language, :type => String
  field :upvoters, :type => Hash
  field :downvoters, :type => Hash

  has_and_belongs_to_many :categories

  referenced_in :user
  embedded_in :kata, :inverse_of => :reviews

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :rating, :numericality => true, :allow_blank => true, :allow_nil => true

end

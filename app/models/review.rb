class Review
  include Mongoid::Document
  field :title, :type => String
  field :content, :type => String
  field :rating, :type => Float
  field :challenge_level, :type => String
  field :language, :type => String
  field :upvoters, :type => Hash
  field :downvoters, :type => Hash

  has_and_belongs_to_many :categories


end

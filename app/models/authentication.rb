class Authentication
  include Mongoid::Document

  field :provider, :type => String
  field :uid, :type => String
  field :user_id, :type => Integer

  validates :provider, :presence => true
  validates :uid, :presence => true
  validates :user_id, :presence => true

  referenced_in :user
end

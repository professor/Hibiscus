class Authentication
  include Mongoid::Document
  referenced_in :user
  
  field :user_id, :type => Integer
  field :provider, :type => String
  field :uid, :type => String
end

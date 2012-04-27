class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, :type => String
  field :time_spent, :type => String

  #########################################################################################################
    # NEHA SINHA
    # Commented part of the below line it was throwing an error, and I could not find any documentation
    # for :opposite
    # Original code is -
    #      embedded_in :post #, :opposite => :comments
    # After commenting out, the error was resolved
  #########################################################################################################

  embedded_in :post #, :opposite => :comments
  referenced_in :user

  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :time_spent, :numericality => true, :allow_blank => true, :allow_nil => true
end

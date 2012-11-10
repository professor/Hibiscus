class AuditTrail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action, :type => String
  field :element_id, :type => Integer
  field :element_type, :type => String

  validates :action, :presence => true
  validates :element_id, :presence => true
  validates :element_type, :presence => true

end
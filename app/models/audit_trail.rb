# Audit Trail is the model that logs documents which are created, updated, etc.

class AuditTrail
  include Mongoid::Document
  include Mongoid::Timestamps

  field :action, :type => String
  field :element_id, :type => Integer
  field :element_class, :type => String
  field :username, :type => String

  validates :action, :presence => true
  validates :element_id, :presence => true
  validates :element_class, :presence => true
  validates :username, :presence => true

end
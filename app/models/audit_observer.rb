# Audit Observer observes elements of type post.

class AuditObserver < Mongoid::Observer
  observe :post


  #def after_update(record)
    #AuditTrail.create(:action => "UPDATED" , :element_id => record.slug, :element_type => record)
  #end

  ##
  # Log audit trail of created documents
  ##
  def after_create(record)
    AuditTrail.create(:action => "CREATED" , :element_id => record.slug, :element_class => record.class, :username => record.user.username)
  end
end
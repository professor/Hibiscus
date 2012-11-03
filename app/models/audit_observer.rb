class AuditObserver < Mongoid::Observer
  observe :post

  def after_update(record)
    #AuditTrail.create(:action => "UPDATED" , :element_id => record.slug, :element_type => record)
  end

  def after_create(record)
    AuditTrail.create(:action => "CREATED" , :element_id => record.slug, :element_type => record)
  end
end
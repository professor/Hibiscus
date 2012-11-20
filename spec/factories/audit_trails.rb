FactoryGirl.define do
  factory :audit_trail do
    action "CREATED"
    element_id "test-post-9"
    element_class "Post"
    username "scotty"
  end

end

# Neha Sinha
# Commenting out below code as Factory.define is deprecated.

#Factory.define :comment do |c|
#  c.content "Comment Content Factory"
#  c.association :user
#  c.association :post
#end


FactoryGirl.define do
  factory :comment do
    content "Comment Content Factory"
    association :user
    association :post
  end
end


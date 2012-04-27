# Neha Sinha
# Commenting out below code as Factory.define is deprecated.

#Factory.define(:activity) do |a|
#  a.name "Programming Project"
#  a.association :plan
#end

FactoryGirl.define do
  factory :activity do
    name "Programming Project"
    association :plan
  end
end
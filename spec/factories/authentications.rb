
# Neha Sinha
# Commenting out below code as Factory.define is deprecated.

#Factory.define(:authentication) do |a|
#  a.provider "Github"
#  a.uid "123"
#  a.association :user
#end

FactoryGirl.define do
  factory :authentication do
    provider "Github"
    uid "123"
    association :user
  end
end
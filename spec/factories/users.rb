
# Neha Sinha
# Commenting out below code as Factory.define is deprecated.

#Factory.define(:user) do |u|
#  u.name "Clark Kent"
#  u.username "ckent"
#  u.email "ckent@wiki.com"
#end



FactoryGirl.define do
  factory :user do
    name "Clark Kent"
    username "ckent"
    email "ckent@wiki.com"
  end
end
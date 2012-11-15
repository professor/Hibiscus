FactoryGirl.define do
  sequence :username do |n|
    "ckent#{n}"
  end

  factory :user do
    name "Clark Kent"
    username
    email "ckent@wiki.com"
  end

  factory :admin, :class => User do
    name "Bruce Wayne"
    username "bwayne"
    email "bwayne@batman.com"
    admin true
  end

end
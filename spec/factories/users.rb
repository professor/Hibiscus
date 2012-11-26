FactoryGirl.define do
  sequence :username do |n|
    "ckent#{n}"
  end

  factory :user do
    name "Clark Kent"
    username
    email "ckent@wiki.com"
    points "0"
    digest_frequency "Weekly"
  end

  factory :admin, :class => User do
    name "Bruce Wayne"
    username "bwayne"
    email "bwayne@batman.com"
    admin true
  end

end
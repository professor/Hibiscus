FactoryGirl.define do
  factory :article do
    guid "retrospective-principles"
    title "Retrospective Principles"
    content "Retrospective Principles"
    association :user
    site_name "George Dinwiddie blog"
    source_url "http://craftsmanship.sv.cmu.edu/"
  end

end
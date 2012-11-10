FactoryGirl.define do
  factory :article do
    guid "retrospective-principles"
    title "Retrospective Principles"
    content "Retrospective Principles"
    site_name "George Dinwiddie blog"
    source_url "http://craftsmanship.sv.cmu.edu/"
    association :user
  end

end
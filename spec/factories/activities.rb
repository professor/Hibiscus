Factory.define(:activity) do |a|
  a.name "Programming Project"
  a.association :plan
end
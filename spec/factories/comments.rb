Factory.define :comment do |c|
  c.content "Comment Content Factory"
  c.association :user
end
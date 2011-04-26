Factory.define(:plan) do |p|
  p.maiden_speech "I'd love to learn about Ruby programming."
  p.association :user
end
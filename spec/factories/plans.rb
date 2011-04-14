Factory.define(:plan) do |p|
  p.maidenSpeech "I'd love to learn about Ruby programming."
  p.association :user
end
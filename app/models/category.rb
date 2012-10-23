# Category is only related to Kata model, representing the category a kata belongs to.

class Category
  include Mongoid::Document

  field :name, :type => String
  key :name

  has_many :katas

  validates :name, :presence => true, :uniqueness => true

  #def setCategory
  #  self.tags.nullify
  #
  #  unless self.tempTags.blank?
  #    tempTags = self.tempTags.split(",")
  #
  #    tempTags.each do |tag|
  #      self.tags << Tag.find_or_create_by(:name => tag.strip.downcase)
  #      # puts "TAGS: " + self.tags.to_s
  #    end
  #  end
  #end

end

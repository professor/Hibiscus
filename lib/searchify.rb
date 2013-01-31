require 'rubygems'
require 'indextank'

module Searchify

  def self.setup_indexes
    api = IndexTank::Client.new(ENV['SEARCHIFY_HIBISCUS_API_URL'] || '<API_URL>')

    index_name = api.indexes(ENV['SEARCHIFY_HIBISCUS_INDEX'] || 'hibiscus')

    index = api.indexes(index_name)
    unless index.exists?
      index.add(:public_search => true)
      puts "created index #{index_name_}"
    end

    indexes = [index_name]

    puts "waiting for indexes to startup"
    indexes.each do |name|
      puts "-#{name}"
      index = api.indexes name
      while not index.running?
        sleep 0.5
      end
    end

    puts "all indexes are running"
  end

  def update_search_index
    url = "#{self.class.name.downcase.pluralize}/" + self.slug
    api = IndexTank::Client.new(ENV['SEARCHIFY_HIBISCUS_API_URL'] || '<API_URL>')

    if self.is_a?(Kata)
      elements = self.survived_reviews
    elsif self.is_a?(Post)
      elements = self.survived_comments
    end

    text = self.content.gsub(/<\/?[^>]*>/, "")
    #if elements.size > 0
    #  elements.each { |element| text << (" " + element.content.to_s)  }
    #end

    index = api.indexes(ENV['SEARCHIFY_HIBISCUS_INDEX'] || 'hibiscus')
    index.document(self.id.to_s).add({ :title => self.title, :timestamp => self.created_at.to_i, :text => text , :url => url, :id => self.id.to_s})
  end

  def delete_from_search_index
    api = IndexTank::Client.new(ENV['SEARCHIFY_HIBISCUS_API_URL'] || '<API_URL>')
    index = api.indexes(ENV['SEARCHIFY_HIBISCUS_INDEX'] || 'hibiscus')
    index.document(self.id.to_s).delete
  end

end

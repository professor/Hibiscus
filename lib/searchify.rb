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
end

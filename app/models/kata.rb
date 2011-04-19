class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.blank?
      begin
        uri = Addressable::URI.parse(value)

        if !["http","https","ftp"].include?(uri.scheme)
          raise Addressable::URI::InvalidURIError
        end
      rescue Addressable::URI::InvalidURIError
        record.errors[attribute] << "Invalid URL"
      end
    end
  end
end 

class Kata
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :type => String
  field :instructions, :type => String
  field :link, :type => String
  
  validates :title, :presence => true
  validates :instructions, :presence => true
  validates :link, :url => true
end
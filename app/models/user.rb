class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not an email") unless
      value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end
end

class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  devise :omniauthable, :rememberable, :trackable
  
  field :name, :type => String
  field :email, :type => String
  
  references_many :authentications, :dependent => :delete
  references_many :posts
  references_many :likes
  # FIXME: Figure out how to make this reference work out.
  # references_many :comments, :through => :posts
  
  validates :name, :presence => true
  validates :email, :presence => true, :email => true
end

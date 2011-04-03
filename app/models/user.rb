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
  
  validates :name, :presence => true
  validates :email, :presence => true, :email => true
  
  references_many :authentications, :dependent => :delete
end

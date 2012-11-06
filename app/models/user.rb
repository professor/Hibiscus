class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not an email") unless
      value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end
end

class User
  include Mongoid::Document
  include Mongoid::Slug
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  include Gamify

  devise :omniauthable, :rememberable, :trackable, :database_authenticatable

  field :name, :type => String
  field :email, :type => String
  field :username, :type => String
  field :gravatar_email, :type=> String
  field :points, :type => Integer
  
  slug :username

  references_many :authentications, :dependent => :delete
  references_many :katas, :dependent => :delete
  references_many :posts, :dependent => :delete
  references_many :likes, :dependent => :delete
  embeds_one :plan

  # FIXME: Figure out how to make this reference work out.
  # references_many :comments, :through => :posts

  validates :username, :presence => true
  # validates :email, :email => true
  
  def display_name
    self.name.blank? ? self.username : self.name
  end
end

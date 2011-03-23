class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  
  field :name, :type => String
  
  validates_presence_of :name
  validates_uniqueness_of :email, :case_sensitive => false   
  attr_accessible :name, :email
  
  references_many :authentications, :dependent => :delete
  
  def register_with_omniauth(omniauth)
    user_info = omniauth['user_info']
    
    self.email = user_info['email'] if email.blank?
    
    # If email is not already in the database, user is new.
    if self.new_record?
      if self.name.blank?
        # Set the name if the user's name is provided by OmniAuth.
        self.name = user_info["name"] unless user_info["name"].blank?
        
        # If the user's name was not provided, attempt to set it using the user's first name and last name, as provided by OmniAuth.
        self.name ||= user_info["first_name"] + " " + user_info["last_name"] unless user_info["first_name"].blank? || user_info["last_name"].blank?
      end
    end
  end
end

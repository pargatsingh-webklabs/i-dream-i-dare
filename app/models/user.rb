class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # before_save :set_default_permissions
  scope :ordered_by_name, -> { order(first_name: :asc) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]

      user.first_name = auth.info.name.split(" ")[0]
      user.last_name = auth.info.name.split(" ")[auth.info.name.split(" ").length-1]
      user.save
      # Removed below- user.provider has a value already, and we cannot access the session variables here.
      #user.provider = session["devise.facebook_data"]["provider"]
      # The image we get from Facebook is a jpeg, size 50 x 50
      # Here is an example: http://graph.facebook.com/v2.10/1192213287595031/picture
      #    user.image = auth.info.image # assuming the user model has an image
      
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

   def set_default_permissions

    # TODO: needs debugging:
      self.is_a_coach = false
      self.is_an_admin = false
      self.is_super_admin = false
   end    
  
  # ensure user account is active  
  def active_for_authentication?  
    self.is_active  
  end  
  
end

# ------------------------------------ FROM TUTORIAL:
# class User < ActiveRecord::Base
#   #attr_accessible :name, :provider, :uid
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable and :omniauthable
#     devise :database_authenticatable, :registerable, :timeoutable,
#         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
#         :omniauth_providers => [:facebook]

#   # before_save :set_default_permissions
#   scope :ordered_by_name, -> { order(first_name: :asc) }

#   def full_name
#     "#{first_name} #{last_name}"
#   end

#   def self.from_omniauth(auth)

#     where(auth.slice(:provider, :uid)).first_or_create do |user|
#         user.email = auth.info.email
#         user.password = Devise.friendly_token[0,20]
#         user.first_name = auth.info.name.split(" ")[0]
#         user.last_name = auth.info.name.split(" ")[auth.info.name.split(" ").length-1]

#       # Removed below- user.provider has a value already, and we cannot access the session variables here.
#       #user.provider = session["devise.facebook_data"]["provider"]
#       # The image we get from Facebook is a jpeg, size 50 x 50
#       # Here is an example: http://graph.facebook.com/v2.10/1192213287595031/picture
#       #    user.image = auth.info.image # assuming the user model has an image
      
#       # If you are using confirmable and the provider(s) you use validate emails, 
#       # uncomment the line below to skip the confirmation emails.
#       # user.skip_confirmation!
#     end
#   end

#    def set_default_permissions

#     # TODO: needs debugging:
#       self.is_a_coach = false
#       self.is_an_admin = false
#       self.is_super_admin = false
#    end    
  
#   # ensure user account is active  
#   def active_for_authentication?  
#     self.is_active  
#   end  

#   def self.new_with_session(params, session)
#       super.tap do |user|
#           if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
#               user.email = data["email"] if user.email.blank?
#           end
#       end
#   end

#   protected 
#   def password_required? 
#     true 
#   end

# end


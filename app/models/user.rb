class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  # before_save :set_default_permissions
  scope :ordered_by_name, -> { order(first_name: :asc) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)

    binding.pry

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]

      user.first_name = auth.info.name.split(" ")[0]
      user.last_name = auth.info.name.split(" ")[auth.info.name.split(" ").length-1]

      user.provider = session["devise.facebook_data"]["provider"]
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

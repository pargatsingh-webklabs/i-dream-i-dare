class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_default_permissions

 private

   def set_default_permissions

    # TODO: needs debugging:
    
    # self.is_a_coach = false
    # self.is_an_admin = false

   end    
   
  # if current_user.try(:admin?)
  # # do something
  # end

end

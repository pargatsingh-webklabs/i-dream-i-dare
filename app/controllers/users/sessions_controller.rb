# This is to customize redirect path after successful login.
 
module Users
  class SessionsController < Devise::SessionsController
   def new
     self.resource = resource_class.new(sign_in_params)
     store_location_for(resource, params[:redirect_to])
     super
   end
  end
end
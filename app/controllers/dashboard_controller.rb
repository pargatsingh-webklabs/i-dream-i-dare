class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  def view

    if user_signed_in?
      
    else redirect_to("/")
    
    #TODO: Add Flash error message if redirected to index due to not being logged in.
    end
  end

  # # TODO: Insert logic to figure out if user is coach, client, or admin. Create instance variables for each scenario. Refactor. EXAMPLE BELOW: 
  #   @

  #   @business = current_user.businesses.find_by_id(params[:business_id])
  #   @clients = @business.clients
  #   if @business.nil?
  #     redirect_to("/businesses/view")
  #   end
    
  # end
end
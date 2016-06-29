class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  def view

    #////////All Users

    if user_signed_in?

      get_user_messages
      
      
      #-----------------

      #////////Coaches

      if current_user.is_a_coach? 

        get_mentorships_for_coach
        get_clients_for_coach

      #////////Admin:

      elsif current_user.is_an_admin?

        get_all_coaches
        get_all_clients
        get_all_mentorships
        get_all_plans

      #////////Clients:

      else 

        get_client_mentorships
        get_client_coaches

      end

      #------------------

    else redirect_to("/") 

    #TODO: Add Flash error message if redirected to index due to not being logged in.
    
    end
  end

#//////////////All Users:

  def get_user_messages
    
    @incoming_messages = Message.where("to" => current_user.id)
    @outgoing_messages = Message.where("from" => current_user.id) 

  end

#//////////////Coaches:

  def get_mentorships_for_coach

    @mentorships = Mentorship.where("coach" => current_user.id)

  end

  def get_clients_for_coach

    @clients = []

    @mentorships.each do |x|
    
      @clients << User.where(:id => x.client)

    end  

  end

#//////////////Clients:

  def get_client_mentorships

    @mentorships_for_client = Mentorship.where("client" => current_user.id)
    
  end

  def get_client_coaches

    @coaches_for_client = []

    @mentorships_for_client.each do |x|

      @coaches_for_client << x.coach

    end
    
  end

#//////////////Admin:

  def get_all_coaches

    @all_coaches = User.where(:is_a_coach)

  end

  def get_all_clients

    @all_clients = User.where(:is_a_coach => false, :is_an_admin => false)

  end

  def get_all_mentorships

    @all_mentorships = Mentorship.all

  end

  def get_all_plans

    @all_plans = Plan.all

  end

  def get_all_messages

    @all_messages = Message.all

  end

end
class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  def view

    # Note: We have ACCESS to params[:active_client_id], if used, from the view.

    #////////All Users

    if user_signed_in?

      get_user_messages

      get_new_message
      
      
      #-----------------

      #////////Coaches

      if current_user.is_a_coach? 

        get_all_mentorships_and_active_client_plans_and_messages_for_coach

      #////////Admin:

      elsif current_user.is_an_admin?
        
        get_all_admin_messages
        get_all_coaches
        get_all_clients
        get_all_mentorships
        get_all_plans
        get_all_messages

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

 # //////////////////////////////////////////////////////

#//////////////All Users:

  def get_user_messages

    a = Message.where(to: current_user.id) 
    b = Message.where(from: current_user.id)
    
    messages = []
    messages << a.flatten
    messages << b.flatten

    @user_messages = messages.flatten.sort_by {|m| m.updated_at }

  end

  def get_new_message

    @message = Message.new

  end

# //////////////////////////////////////////////////////


#//////////////Coaches:

  def get_all_mentorships_and_active_client_plans_and_messages_for_coach

    # GETS ALL CLIENT OBJECTS, stored as @clients:

    mentorships = Mentorship.where(:coach => current_user.id)

    c = []
    
    if mentorships.empty? == false

      mentorships.each do |x|
    
        c << User.where(:id => x.client)

      end

    end

    @clients = c.flatten 

   # ///////////////////////////////////ACTIVE PLANS

   # If an active user designation is not being made, params[:active_client_id] is nil, and we do nothing. 
    # Otherwise, the @active_client_id is used with current_user.id to find all related messages. @all_active_user_plans_sorted_by_timestamp is the resulting collection.


    if params[:active_client_id].nil?

      # DO NOTHING
      
    else  
    
      @active_client_id = params[:active_client_id]

      @all_active_user_plans_sorted_by_timestamp = Plan.where(:client => @active_client_id)

      @all_active_user_plans_sorted_by_timestamp = @all_active_user_plans_sorted_by_timestamp.sort
    

    end

   # ///////////////////////////////////ACTIVE MESSAGES

    # If an active user designation is not being made, params[:active_client_id] is nil, and we do nothing. 
    # Otherwise, the @active_client_id is used with current_user.id to find all related messages. @all_active_user_messages_sorted_by_timestamp is the resulting collection.

    if params[:active_client_id].nil?

      # DO NOTHING
      
    else  
      
      @active_client_id = params[:active_client_id]
      active_messages = []

      @outgoing = Message.where(:to => @active_client_id, :from => current_user.id)

      @incoming = Message.where(:from => @active_client_id, :to => current_user.id)

      @all_active_user_messages_sorted_by_timestamp = []

      @all_active_user_messages_sorted_by_timestamp << @outgoing
      @all_active_user_messages_sorted_by_timestamp << @incoming

      @all_active_user_messages_sorted_by_timestamp = @all_active_user_messages_sorted_by_timestamp.flatten.sort
      end

  end

 # //////////////////////////////////////////////////////


#//////////////Clients:

  def get_client_mentorships

    @mentorships_for_client = Mentorship.where(:client => current_user.id)
    
  end

  def get_client_coaches

    mentorships = Mentorship.where(:client => current_user.id)

    mentorships.each do |x|

      @coaches_for_client = User.where(:id => x.coach)

    end
    
  end

#//////////////Admin:

  def get_all_admin_messages

    @all_admin_messages = AdminMessage.all

  end

  def get_all_coaches

    @all_coaches = User.where(:is_a_coach => true)

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

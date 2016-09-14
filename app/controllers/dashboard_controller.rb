class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  def view
 
    # Note: We have ACCESS to params[:active_user_id], if used, from the view.

    #////////All Users

    if user_signed_in?

      get_user_messages

      get_new_message

      get_new_plan
      
      
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
        get_all_users

      #////////Clients:

      else 

        get_client_plans
        get_client_mentorships_and_coaches
        get_default_active_user_and_messages

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

  def get_new_plan

    @plan = Plan.new

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

      @clients = c.flatten

    else

    end

   # ///////////////////////////////////ACTIVE PLANS

   # If an active user designation is not being made, params[:active_user_id] is nil, and we do nothing. 
    # Otherwise, the @active_user_id is used with current_user.id to find all related messages. @all_active_user_plans_sorted_by_timestamp is the resulting collection.


    if params[:active_user_id].nil?


      # DO NOTHING
      
    else  
    
      @active_user_id = params[:active_user_id]

      @all_active_user_plans_sorted_by_timestamp = Plan.where(:client => @active_user_id)

      @all_active_user_plans_sorted_by_timestamp = @all_active_user_plans_sorted_by_timestamp.sort
    

    end

   # ///////////////////////////////////ACTIVE MESSAGES

    # If an active user designation is not being made, params[:active_user_id] is nil, and we do nothing. 
    # Otherwise, the @active_user_id is used with current_user.id to find all related messages. @all_active_user_messages_sorted_by_timestamp is the resulting collection.

    if params[:active_user_id].nil?

      # DO NOTHING
      
    else  
      
      @active_user_id = params[:active_user_id]
      active_messages = []

      @outgoing = Message.where(:to => @active_user_id, :from => current_user.id)

      @incoming = Message.where(:from => @active_user_id, :to => current_user.id)

      @all_active_user_messages_sorted_by_timestamp = []

      @all_active_user_messages_sorted_by_timestamp << @outgoing
      @all_active_user_messages_sorted_by_timestamp << @incoming

      @all_active_user_messages_sorted_by_timestamp = @all_active_user_messages_sorted_by_timestamp.flatten.sort
    end

  end

 # //////////////////////////////////////////////////////


#//////////////Clients:

  def get_client_mentorships_and_coaches

    @coaches_for_client = []

    @mentorships_for_client = Mentorship.where(:client => current_user.id)

    @mentorships_for_client.each do |x|

      @coaches_for_client << User.where(:id => x.coach)

      @coaches_for_client = @coaches_for_client.flatten
    
      end

  end

  def get_default_active_user_and_messages

      if params[:active_user_id].nil?

        if @coaches_for_client != nil && @coaches_for_client.empty? == false

          @active_user_id = @coaches_for_client[0].id

        else

          @active_user_id = current_user.id

        end

      else  
      
        @active_user_id = params[:active_user_id]
        active_messages = []

        @outgoing = Message.where(:to => @active_user_id, :from => current_user.id)

        @incoming = Message.where(:from => @active_user_id, :to => current_user.id)

        @all_active_user_messages_sorted_by_timestamp = []

        @all_active_user_messages_sorted_by_timestamp << @outgoing
        @all_active_user_messages_sorted_by_timestamp << @incoming

        @all_active_user_messages_sorted_by_timestamp = @all_active_user_messages_sorted_by_timestamp.flatten.sort
      end

  end


  def get_client_plans

    @client_plans = Plan.where(:client => current_user.id)

  end


#//////////////Admin:

  def admin_activate_user

    if current_user.is_an_admin?
      @user = User.find_by_id(params[:target_user_id])
        @user.update_attribute :is_a_coach, false
        @user.update_attribute :is_an_admin, false
    else    
      redirect_to("/")
    end
  end

  def admin_toggle_coach_permissions

    if current_user.is_an_admin?
      @user = User.find_by_id(params[:target_user_id])
      if @user.is_a_coach == true || @user.is_a_coach == nil 
        @user.update_attribute :is_a_coach, false
      else 
        @user.update_attribute :is_a_coach, true
      end
    else    
      redirect_to("/")
    end
  end

  def admin_toggle_admin_permissions

    if current_user.is_an_admin? 
      @user = User.find_by_id(params[:target_user_id])
      if @user.is_an_admin == true || @user.is_an_admin == nil
        @user.update_attribute :is_an_admin, false
      else 
       
        @user.update_attribute :is_an_admin, true
      end
    else 
      redirect_to("/")
    end
  end

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

  # ADMIN ACTION ONLY!
  def get_all_users

    @users = User.all

  end

end

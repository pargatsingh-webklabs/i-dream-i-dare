class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  # /////////////////////////// GROUP DASHBOARD /////////////////////////////

  # Delivers the group dashboard
  def group_view
    get_my_groups
    get_joined_groups
    get_group_invites 
    get_new_group_message
    get_new_group_membership
    get_coach_and_client_network_members
    get_new_group
    get_active_group
    get_members_of_active_group
  end
  
  # TODO: These Need Work!----------------------------------
  def get_group_messages_and_members(group_id)
    get_group_messages(params[:group_id])
    get_group_members(params[:group_id])
  end

    def get_group_messages(group_id)
    @group_messages = GroupMessage.where(:group_id => params[group_id])
  end

  def get_group_members(group_id)
    memberships = Membership.where(:group_id => params[group_id])
    members = []
    owner = []
    memberships.each do |m|
      members << m.user_id
      owner << m.invited_by
    end
    # @group_members = User.where(:id => &&&&&&&)
    # @group_creator = User.where(:id => &&&&&&&)
  end

  # ----------------------------------------------------

  def get_active_group_id
    if params[:active_group_id].nil?
      # DO NOTHING
    else
    @active_group_id = params[:active_group_id] 
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


  # Gets public info for Users
  def get_members_of_active_group
    
    @members_of_active_group = 
  end

  def get_my_groups
    @my_groups = Group.where(:creator => current_user.id)
  end
  
  def get_joined_groups
    joined = []
    group_memberships = GroupMembership.where(:user_id => current_user.id)
    group_memberships.each do |m|
      if m.confirmed == true  
        joined << Group.find_by_id(i.group_id)
      end
    end
    @joined_groups = joined
  end

  def get_group_invites
    invited = []
    group_invites = GroupMembership.where(:user_id => current_user.id)
    group_invites.each do |i|
      if i.confirmed == false
      invited << Group.find_by_id(i.group_id)
      end
    end
    @invited_groups = invited
  end
  
  def get_new_group_message
    @new_group_message = GroupMessage.new
  end

  def get_new_group
    @new_group = Group.new 
  end

  # For the group's creator, to invite a user from their network of clients and/or coaches.
  # New Membership will be created, and "Confirmed" will be set to false.
  def get_new_group_membership
    @new_group_membership = GroupMembership.new
  end

  # Used to populate a drop-down to invite from the user's network of clients and/or coaches.
  # Note that the public results sent in @user_network_members are ONLY ID, FIRST_NAME, LAST_NAME
  def get_coach_and_client_network_members
    network = []
    network_members_public_data = []
    mentorships = Mentorship.where(:coach == current_user.id || :client == current_user.id)
    mentorships.each do |m|
      network << User.find_by_id(m.id)
    end
    network.each do |n|
      network_members_public_data << [n.id]
    end
    @user_network_members = network_members_public_data
  end

  def get_group_network_members
    network = []
    network_members_public_data = []
    memberships = GroupMembership.where(:user_id == current_user.id || :invited_by == current_user.id)
    memberships.each do |m|
      if m.confirmed == true
        user = User.where(:id == m.user_id || :id == m.invited_by)
        users << user
      end
    end
    users.each do |u|
      if u.id != current_user.id
        network_members_public_data << u.id
      end
    end
    @group_network_members = network_members_public_data
  end


  # /////////////////////////////////////////////////////////////////////////

  # ////////////////////////////// USER DASHBOARDS //////////////////////////

  def view
 
    # Note: We have ACCESS to params[:active_user_id], if used, from the view.

    #////////All Users

    if user_signed_in?
      get_user_messages
      get_new_message
      get_new_plan

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

    # GETS ALL CLIENT OBJECTS, stored as @clients
    # GETS ALL CLIENT IDS, stored as @clientsIds
    mentorships = Mentorship.where(:coach => current_user.id)
    c = []
    cIds = []
    if mentorships.empty? == false
      mentorships.each do |x|
        u = User.find_by_id(x.client)
        c << u
        cIds << u.id
      end
      
      @clientsIds = cIds.flatten
      @clients = c.flatten
    else
      # do nothing
      
    end

   # ///////////////////////////////////ACTIVE PLANS

   # If an active user designation is not being made, params[:active_user_id] is nil, and we do nothing. 
    # Otherwise, the @active_user_id is used with current_user.id to find all related messages. @all_active_user_plans_sorted_by_timestamp is the resulting collection.

    if params[:active_user_id].nil?

      # DO NOTHING
      
    else  
      @active_user_id = params[:active_user_id]
      @active_user = User.find_by_id(params[:active_user_id])
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
        @active_user = User.find_by_id(params[:active_user_id])
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

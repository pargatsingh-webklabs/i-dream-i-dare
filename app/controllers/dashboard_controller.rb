class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]


  # /////////////////////////// GROUP DASHBOARD /////////////////////////////

  # ROUTE:     get "/user/group-dashboard"                  => "dashboard#group_view"
  # SECONDARY: get "/user/group-dashboard/:active_group_id" => "dashboard#group_view"

  def group_view
    redirect_to "/landing_page" unless user_signed_in?

    get_my_groups # -- Gets @my_groups (Groups created by the current user)
    get_joined_groups # -- Gets @joined_groups (Groups current user is a member of through invitation from someone else)
    get_group_invites # -- Gets @invited_groups (Groups current user has yet to Confirm membership to)
    get_new_group_message # -- Gets @new_group_message
    get_new_group_membership # -- Gets @new_group_membership
    get_coach_and_client_network_members # -- Gets @user_network_members (an Array of Arrays, each of which consist of (at indexes): [ [0] = id, [1] = first_name, [2] = last_name ] )
    get_new_group # -- Gets @new_group
    get_active_group_id_and_all_group_messages # -- Gets @active_group_id & @all_active_group_messages_sorted_by_timestamp
    get_active_group # -- Gets @active_group (Group object)
    get_all_network_members_through_groups # -- Gets entire list of @group_network_members (an Array of Arrays, each of which consist of (at indexes): [ [0] = id, [1] = first_name, [2] = last_name ] )
    get_members_of_active_group # -- Gets entire list of @active_group_members (an Array of Arrays, each of which consist of (at indexes): [ [0] = id, [1] = first_name, [2] = last_name ] )
    get_new_message
    render layout: "signed-in"
  end
  
  def get_members_of_active_group
    memberships = GroupMembership.where(:group_id => @active_group_id)
    members = []
    owner = []
    public_data = []
    if memberships.empty? == false 
      memberships.each do |m|

        members << m.user_id
        owner << m.invited_by
      end
    end
    if members.empty? == false
      # all_active_user_plans_sorted_by_timestamp
      active_group_members_public_data = []
      members.each do |m|
        if m != nil
          user = User.find_by_id(m)  
          public_data << user.id
          public_data << user.first_name 
          public_data << user.last_name
          active_group_members_public_data << public_data
        end
      end
    end

    if owner.empty? == false
      active_group_owner_public_data = []
      owner.each do |o|
        if o != nil
          owner = User.find_by_id(o)
          public_data << owner.id
          public_data << owner.first_name 
          public_data << owner.last_name
          active_group_owner_public_data << public_data
        end
      end
    end 

    @active_group_members = active_group_members_public_data
    @active_group_owner = active_group_owner_public_data
  end

  # ///////////////////////////////////// ACTIVE GROUP

  def get_active_group_id_and_all_group_messages
    if params[:active_group_id] == nil
      if @my_groups.empty? == false       
        @active_group_id = @my_groups[0].id
      end
      if @joined_groups.empty? == false
        @active_group_id = @joined_groups[0].id
      end
    else
    @active_group_id = params[:active_group_id] 
    active_messages = []
      @all_active_group_messages = GroupMessage.where(:group_id => @active_group_id)
      
      @all_active_group_messages_sorted_by_timestamp = @all_active_group_messages.flatten.sort
    end
  end

  def get_active_group
    if @active_group_id != nil
      @active_group = Group.find_by_id(@active_group_id)
    end
  end

 # //////////////////////////////////////////////////////

  def get_my_groups
    @my_groups = Group.where(:creator => current_user.id)
  end
  

  # COMBINE THESE TWO METHODS:---------------------------->
  def get_joined_groups
    joined = []
    group_memberships = GroupMembership.where(:user_id => current_user.id)
    group_memberships.each do |m|
      if m.confirmed == true  
        g = Group.find_by_id(m.group_id)
        joined << g
      end
    end
    @joined_groups = joined
  end

  def get_group_invites
    invited = []
    group_invites = GroupMembership.where(:user_id => current_user.id)
    if group_invites != nil 
      group_invites.each do |i|
        if i.confirmed == false
          invited << Group.find_by_id(i.group_id)
        end
      end
    end
    @invited_groups = invited
  end

  # -------------------------------------------------------->
  
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
    network_mentorships = Mentorship.where(:coach == current_user.id || :client == current_user.id)

    if network_mentorships.empty? == false
      network_mentorships.each do |m|
          a_net = User.find_by_id(m.coach) 
          b_net = User.find_by_id(m.client)
          if a_net != nil && a_net.id != current_user.id
            network << a_net
          end
          if b_net != nil && a_net.id != current_user.id
            network << b_net
          end
      end
      if network.empty? == false && network.nil? == false

        network.each do |n|
          public_data = []
          public_data << n.id
          public_data << n.first_name 
          public_data << n.last_name
          network_members_public_data << public_data
        end
      end
      @user_network_members = network_members_public_data
    end
  end

  # Gets Public Info for everyone current_user is connected to through all groups
  def get_all_network_members_through_groups
    @all_current_users_groups = []
    if @my_groups.empty? == false
      @my_groups.each do |mg|
        @all_current_users_groups << mg
      end
    end
    if @joined_groups.empty? == false
      @joined_groups.each do |jg|
        @all_current_users_groups << jg 
      end
    end

    # Remove all dupes from this array (@all_current_users_groups).
    @all_memberships_in_current_users_network = []
    @all_current_users_groups.each do |group|
      membership = GroupMembership.where(:group_id => group.id)
      @all_memberships_in_current_users_network << membership.flatten
    end
    users = []
    @all_memberships_in_current_users_network = @all_memberships_in_current_users_network.flatten
    @all_users_in_current_users_network = []
    @all_memberships_in_current_users_network.each do |membership|
      if membership.confirmed == true
        user = User.find_by_id(membership.user_id)
        users << user
      end
    end
    network = []
    users.each do |u|
      public_data = []
      if u.id != current_user.id
        public_data << u.id
        public_data << u.first_name
        public_data << u.last_name
        network << public_data
      end
    end
    
    @all_users_in_current_users_network << network
  end

  # /////////////////////////////////////////////////////////////////////////



  # ////////////////////////////// USER DASHBOARDS //////////////////////////

  # ROUTE:     get "/user/dashboard"                 => "dashboard#view"
  # SECONDARY: get "/user/dashboard/:active_user_id" => "dashboard#view"

  def view
    redirect_to "/landing_page" unless user_signed_in?
    # Note: We have ACCESS to params[:active_user_id], if used, from the view.
    #////////All Users
    if user_signed_in? && current_user.is_super_admin?
      # Check to see if the user wants to login under the current_user.company_id, OR to continue to the Super Admin dashboard
      if 2 == 2
        get_random_quote
        get_user_messages
        get_new_message
        get_new_plan
        render layout: "signed-in"

      else
        get_all_companies_and_new_signups
        render layout: "super-admin"
      
      end

    elsif user_signed_in?
      get_random_quote
      get_user_messages
      get_new_message
      get_new_plan
      #////////Coaches
      if current_user.is_a_coach? 
        get_all_mentorships_and_active_client_plans_and_messages_for_coach
        render layout: "signed-in"
      #////////Admin:
      elsif current_user.is_an_admin?
        get_all_admin_messages
        get_all_coaches
        get_all_clients
        get_all_mentorships
        get_all_plans
        get_all_messages
        get_all_users
        render layout: "signed-in"
      #////////Clients:
      else 
        get_client_plans
        get_client_mentorships_and_coaches
        get_default_active_user_and_messages
        render layout: "signed-in"
      end
    #TODO: Add Flash error message if redirected to index due to not being logged in.
    end
  end

 # //////////////////////////////////////////////////////

# ///////////////////// SUPER ADMIN Users:

  def get_all_companies_and_new_signups
    @all_companies = Company.all
    @users_to_assign_to_company = User.where (:company_id == nil)
  end

  def super_admin_assign_company_id_to_new_user
    u = User.find(params[:target_user_id])
    u.company_id = params[:company_id]
    u.save
  end

  def super_admin_log_into_company
    u = User.find(current_user.id)
    u.company_id = params[:company_id]
    u.save
    redirect_to("/")
  end

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

  def get_new_group_message
    @group_message = GroupMessage.new
  end

  def get_new_plan
    @plan = Plan.new
  end

  def get_random_quote
    @quote = Quote.where(:id => rand(1..(Quote.all.count)))[0]
    
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
    if params[:active_user_id].nil?
      if @clients != nil && @clients.empty? == false
        @active_user = @clients[0]
        @active_user_id = @active_user.id
      end
    else  
      @active_user_id = params[:active_user_id]
      @active_user = User.find_by_id(params[:active_user_id])
    end
    @all_active_user_plans_sorted_by_timestamp = Plan.where(:client => @active_user_id)
    @all_active_user_plans_sorted_by_timestamp = @all_active_user_plans_sorted_by_timestamp.sort


   # ///////////////////////////////////ACTIVE MESSAGES

    # @all_active_user_messages_sorted_by_timestamp is the resulting collection.
    if params[:active_user_id] != nil
      @active_user_id = params[:active_user_id]
    end
    active_messages = []
    @outgoing = Message.where(:to => @active_user_id, :from => current_user.id)
    @incoming = Message.where(:from => @active_user_id, :to => current_user.id)
    @all_active_user_messages_sorted_by_timestamp = []
    @all_active_user_messages_sorted_by_timestamp << @outgoing
    @all_active_user_messages_sorted_by_timestamp << @incoming
    @all_active_user_messages_sorted_by_timestamp = @all_active_user_messages_sorted_by_timestamp.flatten.sort

    @coachDashHeadLine = ContentField.where(:name => "Coach Dashboard Headline")[0]
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
    @coaches_for_client = @coaches_for_client.uniq
    @clientDashHeadLine = ContentField.where(:name => "Client Dashboard Headline")[0]
  end

  def get_default_active_user_and_messages

      if params[:active_user_id].nil?
        if @coaches_for_client != nil && @coaches_for_client.empty? == false
          @active_user = @coaches_for_client[0]
          @active_user_id = @active_user.id
        end
      else  
        @active_user_id = params[:active_user_id]
        @active_user = User.find_by_id(params[:active_user_id])
      end

        active_messages = []
        @outgoing = Message.where(:to => @active_user_id, :from => current_user.id)
        @incoming = Message.where(:from => @active_user_id, :to => current_user.id)
        @all_active_user_messages_sorted_by_timestamp = []
        @all_active_user_messages_sorted_by_timestamp << @outgoing
        @all_active_user_messages_sorted_by_timestamp << @incoming
        @all_active_user_messages_sorted_by_timestamp = @all_active_user_messages_sorted_by_timestamp.flatten.sort
      
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
        Mentorship.where(coach: @user.id).destroy_all
      else 
        @user.update_attribute :is_a_coach, true
      end
      redirect_to("/")
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
      redirect_to("/")
    else 
      redirect_to("/")
    end
  end

  def admin_toggle_active
    if current_user.is_an_admin? 
      @user = User.find_by_id(params[:target_user_id])
      if @user.is_active == true || @user.is_active == nil
        @user.update_attribute :is_active, false
      else 
        @user.update_attribute :is_active, true
      end
      redirect_to("/")
    else 
      redirect_to("/")
    end
  end

  def admin_toggle_deleted
    if current_user.is_an_admin? 
      @user = User.find_by_id(params[:target_user_id])
      if @user.is_deleted == true || @user.is_deleted == nil
        @user.update_attribute :is_deleted, false
      else 
        @user.update_attribute :is_deleted, true
      end
      redirect_to("/")
    else 
      redirect_to("/")
    end
  end

  def get_all_admin_messages
    @all_admin_messages = AdminMessage.all
  end

  def get_all_coaches
    @all_coaches = User.where(:is_a_coach => true, :is_active => true, :company_id => current_user.id, :is_super_admin => nil)
  end

  def get_all_clients 
    @all_clients = User.where(:is_a_coach => false, :is_an_admin => false, :is_active => true, :company_id => current_user.id, :is_super_admin => nil)
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

  def get_all_bios
    @bios = Bios.all
  end

  # ADMIN ACTION ONLY!
  def get_all_users
    @admins = User.where(:is_an_admin => true, :is_deleted => false, :company_id => current_user.id, :is_super_admin => nil).order('is_active desc, first_name, last_name') # Removed :is_active => true for just admin users' view
    @coaches = User.where(:is_an_admin => false, :is_a_coach => true, :is_deleted => false, :company_id => current_user.id, :is_super_admin => nil).order('is_active desc, first_name, last_name') # Removed :is_active => true for just admin users' view
    @users = User.where(:is_an_admin => false, :is_a_coach => false, :is_deleted => false, :company_id => current_user.id, :is_super_admin => nil).order('is_active desc, first_name, last_name') # Removed :is_active => true for just admin users' view
    @users_to_confirm = User.where(:is_a_coach => nil, :company_id => current_user.id, :is_super_admin => nil).order('first_name, last_name')
    @deleted_users = User.where(:is_deleted => true, :company_id => current_user.id, :is_super_admin => nil).order('first_name, last_name')
  end

end

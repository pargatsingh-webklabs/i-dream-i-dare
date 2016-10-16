  class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  def index
    @groups = Group.all
  end

  # GET /groups/1
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  #GET /groups/group_dashboard
  def dashboard
    @user_created_groups = Group.find(:all, :conditions => { :created_by => current_user.id})
    @user_group_memberships = GroupMembership.find(:all, :conditions => { :user_id => current_user.id})

    if @user_group_memberships != null
      groups = []
      @user_group_memberships.each do |m|
        Group.find(:all, :conditions => { :group_id => m.id})
      end
      @user_member_groups = groups.flatten
    end
  end 

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:name, :created_by, :type)
    end
end

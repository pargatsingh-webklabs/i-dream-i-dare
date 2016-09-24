class GroupMembershipsController < ApplicationController
  before_action :set_group_membership, only: [:show, :edit, :update, :destroy]

  # GET /group_memberships
  def index
    @group_memberships = GroupMembership.all
  end

  # GET /group_memberships/1
  def show
  end

  # GET /group_memberships/new
  def new
    @group_membership = GroupMembership.new
  end

  # GET /group_memberships/1/edit
  def edit
  end

  # POST /group_memberships
  def create
    @group_membership = GroupMembership.new(group_membership_params)

    if @group_membership.save
      redirect_to @group_membership, notice: 'Group membership was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /group_memberships/1
  def update
    if @group_membership.update(group_membership_params)
      redirect_to @group_membership, notice: 'Group membership was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /group_memberships/1
  def destroy
    @group_membership.destroy
    redirect_to group_memberships_url, notice: 'Group membership was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_membership
      @group_membership = GroupMembership.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_membership_params
      params.require(:group_membership).permit(:user_id, :group_id, :invited_by)
    end
end

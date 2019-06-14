class GroupDashboardController < ApplicationController
# GET /groups/dashboard
  def dashboard
    @my_created_groups = Group.where(created_by => current_user.id)
    # @my_groups = Group.where()
  end
end
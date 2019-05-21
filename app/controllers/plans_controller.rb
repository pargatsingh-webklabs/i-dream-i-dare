class PlansController < ApplicationController

  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :find_mentorship

  before_filter :authorized_user, only: [:edit, :update, :show, :destroy]
  before_filter :admin_user, only: [:index]
  layout "signed-in"

  # GET /plans
  def index
    @plans = Plan.all
  end

  # GET /plans/1
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit

  end

  # POST /plans
  def create
    @plan = Plan.new(plan_params)
    if current_user.is_an_admin = false && current_user.is_a_coach = false
      @plan.client = current_user.id
    end
    if @plan.save

        id = @plan.id
        alerts = AlertsController.new
        alerts.request = request
        alerts.response = response
        alerts.send_notifications("plan_created", id)
      
      redirect_to "/user/dashboard", notice: 'Plan was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /plans/1
  def update
    if @plan.update(plan_params)

      id = @plan.id
        alerts = AlertsController.new
        alerts.request = request
        alerts.response = response
        alerts.send_notifications("plan_created", id)
      
      redirect_to "/user/dashboard", notice: 'Plan was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /plans/1
  def destroy
    # render :text => 'fsdfsdfs<%= sign_in_params %>'
    @plan.destroy
    redirect_to "/user/dashboard/", notice: 'Plan was successfully destroyed.'
  end

  protected 

  def authorized_user
    if (@plan.client == current_user.id)

    elsif @mentorship.present?
      redirect_to "/" unless @plan.client == current_user.id || @clientsIds.include?(@plan.client) 

    elsif @coach_mentorships.present?

      @clients_of_coach = []

      @coach_mentorships.each do |m|

        @clients_of_coach << m.client

    end

      redirect_to "/" unless @clients_of_coach.include?(@plan.client)
      
    else redirect_to "/" unless current_user.is_an_admin?
    end

  end

  def admin_user
    # Is the current user an admin? If not, user is redirected to their dashboard. 
    redirect_to "/" unless current_user.is_an_admin == true
  end

# ////////////////////////////////

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def find_mentorship
      if current_user.is_a_coach? == false && current_user.is_an_admin? == false
        @mentorship = Mentorship.find_by(client: current_user.id)
      elsif current_user.is_a_coach? && current_user.is_an_admin? == false
        @coach_mentorships = Mentorship.where(coach: current_user.id)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def plan_params
      params.require(:plan).permit(:client, :title, :content)
    end
end

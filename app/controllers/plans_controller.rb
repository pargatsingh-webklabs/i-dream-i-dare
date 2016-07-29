class PlansController < ApplicationController

   before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # /////////////////////////////

  before_filter :authorized_user, only: :show
  before_filter :authorized_coach_or_admin, only: [:edit, :update, :destroy]
  before_filter :admin_user, only: [:index]

  
  # /////////////////////////////


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

    if @plan.save
      redirect_to @plan, notice: 'Plan was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /plans/1
  def update
    if @plan.update(plan_params)
      redirect_to @plan, notice: 'Plan was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /plans/1
  def destroy
    @plan.destroy
    redirect_to plans_url, notice: 'Plan was successfully destroyed.'
  end


  # Can only be called within this controller////////////////
  protected 



  def authorized_user

    # Does the plan belong to the current user?
    redirect_to "/hit_auth_user_filter" unless @plan.client == current_user.id || @mentorship != nil && @mentorship.coach == current_user.id || current_user.is_an_admin?

  end

  def authorized_coach_or_admin

    # Is the coach of the plan's owner the current user, or is the current user an admin?
    

    if @mentorship != nil
      redirect_to "/hit_auth_coach_filter" unless  @mentorship.coach == current_user.id || current_user.is_an_admin?
    else
      redirect_to "/hit_auth_coach_filter_nil"
    end

  end

  def admin_user

    # Is the current user an admin?
    redirect_to "/hit_auth_admin_filter" unless current_user.is_an_admin == true

  end

# ////////////////////////////////


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def find_mentorship
      @mentorship = Mentorship.find_by_client(current_user.id)
    end

    # Only allow a trusted parameter "white list" through.
    def plan_params
      params.require(:plan).permit(:client, :title, :content)
    end
end

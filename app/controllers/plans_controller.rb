class PlansController < ApplicationController
  before_action :confirm_logged_in
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # /////////////////////////////

  before_filter :nil_check
  before_filter :authorized_user, only: :show
  before_filter :authorized_coach, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user, only: [:show, :index, :edit, :update, :destroy]


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

  # Can only be called within this controller
  protected 


  
  def nil_check
    
    # Find the current user's mentorship.
    @mentorship = Mentorship.where(client => current_user.id)

    redirect_to "/hit_auth_user_filter_nil_check" if @mentorship == nil

  end  

  def authorized_user

    # Does the plan belong to the current user?
    redirect_to "/hit_auth_user_filter" if @plan.client != current_user.id && @mentorship.coach != current_user.id && current_user.is_an_admin != true

  end

  def authorized_coach

    # Is the coach of the plan's owner the current user?
    redirect_to "/hit_auth_coach_filter" if @mentorship.coach != current_user.id && current_user.is_an_admin != true

  end

  def admin_user
    # Is the current user an admin?
    redirect_to "/hit_auth_admin_filter" if current_user.is_an_admin != true

  end

# ////////////////////////////////


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def plan_params
      params.require(:plan).permit(:client, :title, :content)
    end
end

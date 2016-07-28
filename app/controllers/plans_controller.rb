class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # /////////////////////////////


  # before_filter :signed_in_user
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


  protected

  def authorized_user

    redirect_to "/user/dashboard" unless current_user != nil && current_user.id == Plan.find_by_id(params[:id]).client
  end

  def authorized_coach
    
    # redirect_to 'dashboard/view' unless current_user != nil && 

    # current_user.id == Mentorship.where(User.find_by_id(Plan.find_by_id(params[:id]).client).id)

  end

  def admin_user
    redirect_to 'index' unless current_user != nil && current_user.is_an_admin?
  end

  # Also, try: 

  # flash[:notice] = "You may only view your own products."

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

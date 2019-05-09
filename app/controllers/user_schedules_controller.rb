class UserSchedulesController < ApplicationController
  before_action :set_user_schedule, only: [:show, :edit, :update, :destroy]

  layout "signed-in"

  def full_calendar
    @all_my_user_schedules = UserSchedule.where(user_id: current_user.id)
  end

  def user_create_new
    @user_schedule = UserSchedule.new
  end

  # GET /user_schedules
  def index
    @user_schedules = UserSchedule.all
  end

  # GET /user_schedules/1
  def show
  end

  # GET /user_schedules/new
  def new
    @user_schedule = UserSchedule.new
  end

  # GET /user_schedules/1/edit
  def edit
  end

  # POST /user_schedules
  def create
    @user_schedule = UserSchedule.new(user_schedule_params)

    if @user_schedule.save
      redirect_to @user_schedule, notice: 'User schedule was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /user_schedules/1
  def update
    if @user_schedule.update(user_schedule_params)
      redirect_to @user_schedule, notice: 'User schedule was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /user_schedules/1
  def destroy
    @user_schedule.destroy
    redirect_to user_schedules_url, notice: 'User schedule was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_schedule
      @user_schedule = UserSchedule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_schedule_params
      params.require(:user_schedule).permit(:user_id, :schedule_id, :completed)
    end
end

class MentorshipsController < ApplicationController
  before_action :set_mentorship, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user

  # GET /mentorships
  def index
    @mentorships = Mentorship.all
    get_all_coaches
    get_all_clients 
  end

  # GET /mentorships/1
  def show
    get_all_coaches
    get_all_clients 
  end

  # GET /mentorships/new
  def new
    @mentorship = Mentorship.new
    get_all_coaches
    get_all_clients 
  end

  # GET /mentorships/1/edit
  def edit
    get_all_coaches
    get_all_clients 
  end

  # POST /mentorships
  def create
    @mentorship = Mentorship.new(mentorship_params)

    if @mentorship.save
      redirect_to @mentorship, notice: 'Mentorship was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mentorships/1
  def update
    if @mentorship.update(mentorship_params)
      redirect_to @mentorship, notice: 'Mentorship was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mentorships/1
  def destroy
    @mentorship.destroy
    redirect_to mentorships_url, notice: 'Mentorship was successfully destroyed.'
  end

  private

    def admin_user
      redirect_to "/hit_admin_user_filter" unless current_user.is_an_admin?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_mentorship
      @mentorship = Mentorship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mentorship_params
      params.require(:mentorship).permit(:client, :coach)
    end

    def get_all_coaches

    @all_coaches = User.where(:is_a_coach => true)

  end

  def get_all_clients 

    @all_clients = User.where(:is_a_coach => false, :is_an_admin => false)

  end
end

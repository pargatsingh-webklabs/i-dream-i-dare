class MentorshipsController < ApplicationController
  before_action :set_mentorship, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user, only: [:index, :show, :edit, :update, :destroy]

  layout "signed-in"

  # GET /mentorships
  def index
    get_all_coaches_and_clients
    @all_mentorships = Mentorship.all
    @public_mentorship_data = []

    if @all_mentorships.empty? == false
      @all_mentorships.each do |m|
        mentorship_relation = []
        mentorship_relation << m.id
        mentorship_relation << coach = @all_coaches.find_by_id(m.coach)
        mentorship_relation <<  client = @all_clients.find_by_id(m.client)
        if coach == nil || client == nil
          removeMentorship = Mentorship.find_by_id(m.id)
          removeMentorship.active = false
          removeMentorship.save
        else @public_mentorship_data << mentorship_relation
        end
      end
    end
  end

  # GET /mentorships/1
  def show
    get_all_coaches_and_clients
  end

  # GET /mentorships/new
  def new
    @mentorship = Mentorship.new
    get_all_coaches_and_clients
  end

  # GET /mentorships/1/edit
  def edit
    get_all_coaches_and_clients
  end

  # POST /mentorships
  def create
    @mentorship = Mentorship.new(mentorship_params)
      @mentorship.active = true
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
      redirect_to "/" unless current_user.is_an_admin?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_mentorship
      @mentorship = Mentorship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mentorship_params
      params.require(:mentorship).permit(:client, :coach)
    end

    def get_all_coaches_and_clients
      @all_coaches = User.where(:is_a_coach => true)
      @all_clients = User.where(:is_a_coach => false, :is_an_admin => false)
    end
end

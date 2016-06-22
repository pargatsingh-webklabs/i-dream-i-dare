class MentorshipsController < ApplicationController
  before_action :set_mentorship, only: [:show, :edit, :update, :destroy]

  # GET /mentorships
  def index
    @mentorships = Mentorship.all
  end

  # GET /mentorships/1
  def show
  end

  # GET /mentorships/new
  def new
    @mentorship = Mentorship.new
  end

  # GET /mentorships/1/edit
  def edit
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
    # Use callbacks to share common setup or constraints between actions.
    def set_mentorship
      @mentorship = Mentorship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mentorship_params
      params.require(:mentorship).permit(:client, :coach)
    end
end

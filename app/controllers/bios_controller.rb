class BiosController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:root_path]
  before_action :set_bio, only: [:show, :edit, :update, :destroy]

  # GET /bios
  def index
    @bios = Bio.where(:profile_active => true)
    @bio_users = []

    @bios.each do |bio|
      binding.pry
      @bio_users << User.find(bio.user_id)
    end

    render layout: "application"
  end

  # GET /bios/1
  def show
  end

  # GET /bios/new
  def new
    @bio = Bio.new
  end

  # GET /bios/1/edit
  def edit
  end

  # POST /bios
  def create
    @bio = Bio.new(bio_params)

    if @bio.save
      redirect_to @bio, notice: 'Bio was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bios/1
  def update
    if @bio.update(bio_params)
      redirect_to @bio, notice: 'Bio was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bios/1
  def destroy
    @bio.destroy
    redirect_to bios_url, notice: 'Bio was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bio
      @bio = Bio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bio_params
      params.require(:bio).permit(:user_id, :profile_text, :style_text, :expertise)
    end
end

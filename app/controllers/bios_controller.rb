class BiosController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:meet_us]
  before_action :set_bio, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user, only: [:index, :destroy, :show, :edit, :update, :new]
  before_action :collect_public_facing_variables
  layout "signed-in" # Layout Default

  # GET /bios
  def index
    @bios = Bio.all
    
  end

  # GET /bios/1
  def show
  end

  # GET /bios/new
  def new
    @bio = Bio.new
    get_all_coaches
  end

  # GET /bios/1/edit
  def edit
    get_all_coaches
  end

  # POST /bios
  def create
    @bio = Bio.new(bio_params)
    @bio.profile_active = true

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
    def admin_user
      redirect_to "/422" unless current_user != nil && current_user.is_an_admin?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_bio
      @bio = Bio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bio_params
      params.require(:bio).permit(:user_id, :profile_text, :style_text, :expertise, :profile_image)
    end

    def get_all_coaches
      @all_coaches = User.where(:is_a_coach => true)
    end
end

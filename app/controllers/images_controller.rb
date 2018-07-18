class ImagesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :edit, :update, :new]
  before_filter :admin_user, only: [:index, :destroy]
  layout "signed-in" # Layout Default
  respond_to :json

  def create
    image_params[:image].open if image_params[:image].tempfile.closed?
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.json { render json: { url: @image.image_url }, status: :ok }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @images = Image.where.not(:image_data => nil)
  end

  def index
    @images = Image.where.not(:image_data => nil)
  end

  def new
    @image = Image.new
  end

  # def create
  #   @image = Image.new(image_params)
  #   if @image.save
  #     flash[:success] = 'Image Added!'
  #     @images = Image.where.not(:image_data => nil)
  #     render 'index'
  #   else
  #     @image = Image.new
  #     render 'new'
  #   end
  # end

  def edit 
    @image = Image.find(params[:id])
  end

  def update 
    @image = Image.find(params[:id])
    if @image.update_attributes(image_params)
      flash[:success] = 'Image Edited!'
      @images = Image.where.not(:image_data => nil)
      render 'index'
    else
      render 'edit'
    end
  end

  def upload
  end

  private
  def admin_user
    redirect_to "/422" unless current_user != nil && current_user.is_an_admin?
  end

  def image_params
    params.require(:image).permit(:image, :remove_image)
  end

end
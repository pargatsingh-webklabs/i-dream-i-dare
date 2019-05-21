class ContentFieldsController < ApplicationController
  before_action :set_content_field, only: [:show, :edit, :update, :destroy]
  layout "signed-in"
  
  # GET /content_fields
  def index
    @content_fields = ContentField.all
  end

  # GET /content_fields/1
  def show
  end

  # GET /content_fields/new
  def new
    @content_field = ContentField.new
  end

  # GET /content_fields/1/edit
  def edit
  end

  # POST /content_fields
  # def create
  #   @content_field = ContentField.new(content_field_params)

  #   if @content_field.save
  #     redirect_to @content_field, notice: 'Content field was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # PATCH/PUT /content_fields/1
  def update
    if @content_field.update(content_field_params)
      redirect_to @content_field, notice: 'Content field was successfully updated.'
    else
      render :edit
    end
  end

  # # DELETE /content_fields/1
  # def destroy
  #   @content_field.destroy
  #   redirect_to content_fields_url, notice: 'Content field was successfully destroyed.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_field
      @content_field = ContentField.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def content_field_params
      params.require(:content_field).permit(:name, :value)
    end
end

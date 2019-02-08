class BookResourcesController < ApplicationController
  before_action :set_book_resource, only: [:show, :edit, :update, :destroy]

  # GET /book_resources
  def index
    @book_resources = BookResource.all
    render layout: "signed-in"
  end

  # GET /book_resources/1
  def show
    render layout: "signed-in"
  end

  # GET /book_resources/new
  def new
    @book_resource = BookResource.new

    # Add defaults
    @book_resource.active = true
    render layout: "signed-in"
  end

  # GET /book_resources/1/edit
  def edit
    render layout: "signed-in"
  end

  # POST /book_resources
  def create
    @book_resource = BookResource.new(book_resource_params)

    uploaded_io = params[:book_resource][:file]
    File.open(Rails.root.join('public/upload/', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

     @book_resource.path = 'public/upload/'
     @book_resource.file_name = params[:book_resource][:file].original_filename
     
    if @book_resource.save
      redirect_to @book_resource, notice: 'Book resource was successfully created.'
    else
      render layout: "signed-in"
    end
  end

  # PATCH/PUT /book_resources/1
  def update
    if @book_resource.update(book_resource_params)
      redirect_to @book_resource, notice: 'Book resource was successfully updated.'
    else
      # render :edit
      render layout: "signed-in"
    end
  end

  # DELETE /book_resources/1
  def destroy
    @book_resource.destroy
    redirect_to book_resources_url, notice: 'Book resource was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_resource
      @book_resource = BookResource.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # Removed "path" from trusted list, so we keep this set to the default folder.
    def book_resource_params
      params.require(:book_resource).permit(:active, :file_name, :path)
    end
end

require 'zip'

class AdminMessagesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:root_path]
  before_action :set_admin_message, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user, only: [:show, :index, :edit, :update, :destroy]

  # /////////////////////////////

  # GET /
  def landing_page
    time = Time.new
    days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    @day_of_week = days[time.wday] 
    @month = time.month
    @day_number = time.day
    @year = time.year

    @active_book_resources = BookResource.where(active: true)
    @book_resource_request = ResourceRequest.new("")

    @admin_message = AdminMessage.new

    render layout: "application"
  end

  def download_book_resources # See user_mailer controller for the send resources method

    # # Identify our book resources

    # active_book_resources = BookResource.where(active: true)

    # # Create a zipfile
    # filename = 'Dream_Dare_Resources.zip'
    # temp_file = Tempfile.new(filename)
 
    # begin

    #   #Initialize the temp file as a zip file
    #   Zip::OutputStream.open(temp_file) { |zos| }
     
    #   #Add files to the zip file as usual
    #   Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|

    #     active_book_resources.each do |res|
        
    #     # Adding static files
    #     # zip.add("Compelling Vision Worksheet PDF.pdf", "app/assets/bookresources/Compelling Vision Worksheet PDF.pdf")
    #     # zip.add("Coaching Contract (with tips) PDF.pdf", "app/assets/bookresources/Coaching Contract (with tips) PDF.pdf")

    #     zip.add(res.file_name, res.path + res.file_name)

    #     end

    #   end
     
    #   #Read the binary data from the file
    #   zip_data = File.read(temp_file.path)
      
      

    #   #Send the data to the browser as an attachment
    #   #We do not send the file directly because it will
    #   #get deleted before rails actually starts sending it
    #   send_data(zip_data, :type => 'application/zip', :filename => filename)
    # ensure
    #   #Close and delete the temp file
    #   temp_file.close
    #   temp_file.unlink
    # end
  end

  # GET /admin_messages
  def index
    @all_admin_messages = []
    all_messages = AdminMessage.all
    all_messages.each do |m|
      @all_admin_messages << m
    end
    render layout: "signed-in"
  end

  # GET /admin_messages/1
  def show
    render layout: "signed-in"
  end

  # GET /admin_messages/new
  def new
    @admin_message = AdminMessage.new
    # render layout: "signed-in"
  end

  # GET /admin_messages/1/edit
  def edit
    render layout: "signed-in"
  end

  # POST /admin_messages
  def create
    @admin_message = AdminMessage.new(admin_message_params)

    if @admin_message.save
      redirect_to "/", notice: 'Admin message was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin_messages/1
  def update
    if @admin_message.update(admin_message_params)
      redirect_to @admin_message, notice: 'Admin message was successfully updated.'
    else
      render :edit
      render layout: "signed-in"
    end
  end

  # DELETE /admin_messages/1
  def destroy
    @admin_message.destroy
    redirect_to admin_messages_url, notice: 'Admin message was successfully destroyed.'
  end

# /////////////This is my before filter that prevents unauth access to view admin messages.////////////////////

  protected

  def admin_user
    redirect_to 'index' unless current_user != nil && current_user.is_an_admin?
  end

  # Also, try: 

  # flash[:notice] = "You may only view your own products."

# ////////////////////////////////



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_message
      @admin_message = AdminMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_message_params
      params.require(:admin_message).permit(:from_name, :from_email, :content)
    end
end

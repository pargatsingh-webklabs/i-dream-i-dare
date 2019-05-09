class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def confirm_logged_in
  #   unless session[:user_id]
  #     flash[:notice] = "You must be logged in to do that"
  #     redirect_to "root_path"
  #     return false
  #   else
  #     return true
  #   end
  # end

  def collect_public_facing_variables

    @active_bios = Bio.where(:profile_active => true)
    @book_resource_request = ResourceRequest.new("")
    
    if !@active_bios.empty?
      @active_bio_questions = BioQuestion.where(:active => true).order(:question_order_by)

      @active_bio_question_ids = []
      
      @active_bio_questions.each do |b|
        @active_bio_question_ids << b.id
      end
      
      @active_bio_answers = BioAnswer.where(:bio_question_id => @active_bio_question_ids)
      @active_bio_users = []

      @active_bios.each do |bio|
        @active_bio_users << User.find(bio.user_id)
      end

      @active_book_resources = BookResource.where(active: true)

    else

      @active_book_resources = BookResource.where(active: true)

    end
  end

end

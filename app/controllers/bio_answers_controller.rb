class BioAnswersController < ApplicationController
  before_action :set_bio_answer, only: [:show, :edit, :update, :destroy]

  #UPDATE THIS TO INCLUDE COACHES, AND FILL USER_ID FIELD ON CREATE
  before_filter :admin_user, only: [:index, :show, :edit, :update, :destroy]
  
  layout "signed-in"

  # GET /bio_answers
  def index
    @bio_answers = BioAnswer.all
  end

  # GET /bio_answers/1
  def show
  end

  # GET /bio_answers/new
  def new
    @bio_answer = BioAnswer.new
  end

  # GET /bio_answers/1/edit
  def edit
  end

  # POST /bio_answers
  def create
    @bio_answer = BioAnswer.new(bio_answer_params)
      
    if @bio_answer.save
      redirect_to @bio_answer, notice: 'Bio answer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bio_answers/1
  def update
    if @bio_answer.update(bio_answer_params)
      redirect_to @bio_answer, notice: 'Bio answer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bio_answers/1
  def destroy
    @bio_answer.destroy
    redirect_to bio_answers_url, notice: 'Bio answer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bio_answer
      @bio_answer = BioAnswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bio_answer_params
      params.require(:bio_answer).permit(:bio_question_id, :answer_text, :user_id)
    end

    def admin_user
      redirect_to "/" unless current_user.is_an_admin?
    end
end

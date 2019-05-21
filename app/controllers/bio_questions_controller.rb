class BioQuestionsController < ApplicationController
  before_action :set_bio_question, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user, only: [:index, :show, :edit, :update, :destroy]

  layout "signed-in"

  # GET /bio_questions
  def index
    @bio_questions = BioQuestion.all
  end

  # GET /bio_questions/1
  def show
  end

  # GET /bio_questions/new
  def new
    @bio_question = BioQuestion.new
  end

  # GET /bio_questions/1/edit
  def edit
  end

  # POST /bio_questions
  def create
    @bio_question = BioQuestion.new()
    @bio_question.question_text = bio_question_params["question_text"]
    @bio_question.question_order_by = 0
    @bio_question.active = false

    if @bio_question.save
      redirect_to @bio_question, notice: 'Bio question was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bio_questions/1
  def update
    if @bio_question.update(bio_question_params)
      redirect_to @bio_question, notice: 'Bio question was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bio_questions/1
  def destroy
    @bio_question.destroy
    redirect_to bio_questions_url, notice: 'Bio question was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bio_question
      @bio_question = BioQuestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bio_question_params
      params.require(:bio_question).permit(:question_text, :question_order_by, :active)
    end

    def admin_user
      redirect_to "/" unless current_user.is_an_admin?
    end
end

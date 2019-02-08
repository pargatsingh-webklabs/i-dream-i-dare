class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user, only: [:index, :destroy, :edit, :update, :new]
  layout "signed-in" # Layout Default
  # GET /quotes
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to @quote, notice: 'Quote was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /quotes/1
  def update
    if @quote.update(quote_params)
      redirect_to @quote, notice: 'Quote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /quotes/1
  def destroy
    @quote.destroy
    redirect_to quotes_url, notice: 'Quote was successfully destroyed.'
  end

  private
     def admin_user
    redirect_to 'index' unless current_user != nil && current_user.is_an_admin?
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quote_params
      params.require(:quote).permit(:body, :author, :url_for_image)
    end
end

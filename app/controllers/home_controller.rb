class HomeController < ApplicationController
  before_action :collect_public_facing_variables
  skip_before_filter :authenticate_user!, only: [:meet_us]

  def index
    @active_book_resources = BookResource.where(active: true)
  end

  def about
    @active_book_resources = BookResource.where(active: true)
  end

  def blog
  	@active_book_resources = BookResource.where(active: true)
  end

    # GET /meet_us
  def meet_us

  end

end
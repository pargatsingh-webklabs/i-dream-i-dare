class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  def index
    @active_book_resources = BookResource.where(active: true)
  end

  def about
    @active_book_resources = BookResource.where(active: true)
  end

  def blog
  	@active_book_resources = BookResource.where(active: true)
  end
end
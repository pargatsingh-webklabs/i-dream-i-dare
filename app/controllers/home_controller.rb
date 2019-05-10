class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :about, :blog, :meet_us]
  before_action :collect_public_facing_variables, only: [:index, :about, :blog, :meet_us]
  
  layout "application"

  def index
  end

  def about
  end

  def blog
  end

  def meet_us
  end
  
end
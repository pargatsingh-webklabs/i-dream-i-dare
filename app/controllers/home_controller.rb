class HomeController < ApplicationController
  before_action :collect_public_facing_variables
  
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
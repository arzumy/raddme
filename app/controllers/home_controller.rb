class HomeController < ApplicationController
  def index
    redirect_to public_user_path(current_user) if user_signed_in?
  end

  def about
  end
end

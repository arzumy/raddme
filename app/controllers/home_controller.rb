class HomeController < ApplicationController
  def index
    redirect_to public_user_path(current_user) if user_signed_in?
  end

  def exchange
    user = User.find_by_invite_token(params[:token])
    if user
      sign_in(user)
      redirect_to edit_user_path(user)
    else
      redirect_to root_path, alert: "We can't find your invitation, perhaps you want to register?"
    end
  end
end

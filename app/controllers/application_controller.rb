class ApplicationController < ActionController::Base
  protect_from_forgery

  def public_user_path(user)
    root_path+user.to_param
  end

  def public_user_url(user)
    root_url+user.to_param
  end
end

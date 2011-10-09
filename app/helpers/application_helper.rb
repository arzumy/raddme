module ApplicationHelper
  def public_user_path(user)
    root_path+user.to_param
  end
end

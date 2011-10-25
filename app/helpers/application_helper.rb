module ApplicationHelper
  def offline_manifest
    return {} unless user_signed_in?
    {:manifest => "raddme.appcache"}
  end

  def root_path
    return super unless user_signed_in?
    public_user_path(current_user, format: :html)
  end
end

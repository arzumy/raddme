module ApplicationHelper
  def offline_manifest
    return {} unless user_signed_in?
    {:manifest => "/raddme.appcache"}
  end
end

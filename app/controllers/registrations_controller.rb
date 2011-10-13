class RegistrationsController < Devise::RegistrationsController
  rescue_from ActiveRecord::RecordNotUnique, with: :show_reset_password

  def show_reset_password
    redirect_to new_user_password_path, notice: "Seems like you've registered before. Let's try resetting your password"
  end
end
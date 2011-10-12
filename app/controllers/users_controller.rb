class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :get_user, only: [:show]
  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      current_user.register!
      redirect_to public_user_path(current_user)
    else
      render :edit
    end
  end

  def get_user
    @user = User.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @user
  end
end

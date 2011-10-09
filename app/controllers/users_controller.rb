class UsersController < ApplicationController
  before_filter :get_user
  def show
    
  end

  def get_user
    @user = User.find_by_id(params[:id])
    raise ActiveRecord::RecordNotFound unless @user
  end
end

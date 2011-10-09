class FriendshipsController < ApplicationController
  before_filter :get_user, only: [:create]
  before_filter :get_friend, only: [:create]
  def create
    @user.add_friend(@friend)
    if @friend.registered?
      redirect_to root_path+@user.to_param, notice: "You've successfully exchanged contact"
    end
  end

  def get_user
    @user = User.find_by_id(params[:user][:id])
    raise ActiveRecord::RecordNotFound unless @user
  end

  def get_friend
    @friend = User.find_by_email(params[:user][:email])
    unless @friend
      @friend = User.dummy_create(params[:user][:email])
    end
  end
end

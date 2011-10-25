class FriendshipsController < ApplicationController
  before_filter :get_user, only: [:create]
  before_filter :get_friend, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :email_not_valid
  def create
    @user.add_friend(@friend)
    if @friend.registered?
      UserMailer.exchanged(@user, @friend).deliver
      UserMailer.exchanged(@friend, @user).deliver
      notice = "You've successfully exchanged contact"
    else
      UserMailer.exchanged_unregistered(@user, @friend).deliver
      notice = "You've shared contact with #{@friend.email}. As soon as they login, you will receive their card"
    end

    if request.xhr?
      head :ok
    else
      redirect_to public_user_path(@user), notice: notice
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

  def email_not_valid
    redirect_to public_user_path(@user), alert: "Your email is invalid dude"
  end
end

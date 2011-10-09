class UserMailer < ActionMailer::Base
  default from: "just@radd.me"

  def exchanged_unregistered(user, friend)
    @user = user
    @friend = friend
    mail(:to => friend.email, :subject => "Here's #{@user.fullname} details on Radd.me")
  end
end

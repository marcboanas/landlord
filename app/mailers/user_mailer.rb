class UserMailer < ActionMailer::Base
  default from: "robot@landlords.com"

  def user_signup(user)
    @user = user
    mail to: @user.email, subject: "Welcome, #{@user.full_name}"
  end

  def account_verification(user)
    @user = user
    mail to: @user.email, subject: "Verification Email"
  end

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Reset Password"
  end
end

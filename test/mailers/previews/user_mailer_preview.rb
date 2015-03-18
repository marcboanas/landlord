# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_verification
  def account_verification
    UserMailer.account_verification
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/user_signup
  def user_signup
    UserMailer.user_signup
  end

end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && User.authenticate(false, params[:session][:email], params[:session][:password])

      # Log in the user regardless if the email has verified or not

      if user.email_verification? || !user.email_verification
        log_in user
        params[:session][:remember] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else

        # This error won't be displayed even if the email hasn't been verified

        message = "Email not verified!"
        message += "Check your email for the verification link"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

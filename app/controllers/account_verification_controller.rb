class AccountVerificationController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.email_verification? && user.authenticated?(:verification, params[:id])
      user.verified
      user.save!
      log_in user
      flash[:success] = "Account verified!"
      redirect_to user
    else
      flash[:danger] = "Invalid verification link"
      redirect_to root_url
    end
  end
end

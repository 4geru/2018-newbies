class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    # Use !user.activated? here to ensure illegal access would not be grangted.
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
<<<<<<< HEAD
      flash[:success] = "Account activated! Please log in."
      redirect_to login_url
=======
      flash[:success] = "アカウントの有効化に成功しました"
      redirect_to dashboard_path
>>>>>>> 2450747b5a2f09d0896d80a0a980a1fc330df9a7
    else
      flash[:alert] = "無効なリンクです"
      redirect_to login_url
    end
  end
end

# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path, alert:'ログイン済みです' if current_user
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user && @user.authenticate(params[:user][:password])
      if @user.activated?
        log_in @user
        redirect_to dashboard_path, notice: 'ログインしました'
      else
        flash[:alert] = 'アカウント有効化のメールを確認してください。'
        redirect_to root_url
      end
    else
      redirect_to login_path, alert: 'ユーザーが存在しないかパスワードが間違っています'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path, notice: 'ログアウトしました'
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

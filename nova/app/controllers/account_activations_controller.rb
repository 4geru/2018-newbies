class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    # Use !ser.activated? here to ensure illegal access would not be grangted.
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      puts '----------------activation succeeded----goint to login_url----session#new-------'
      flash[:success] = "Account activated! Please log in."
      redirect_to login_url
    else
      flash[:danger] = "Invalid activation link!"
      redirect_to login_url
    end
  end
end

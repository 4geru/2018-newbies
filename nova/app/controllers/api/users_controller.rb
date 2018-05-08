# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController
  def show
    render json: current_user
  end

  def update
    puts 'params >> '
    puts params
    current_user.update!(user_params)

    # current_user.credit_card.try(:destroy)
    # @credit_card = CreditCard.create!(credit_card_params.merge(user: current_user))

    render json: current_user
  rescue ActiveRecord::RecordInvalid => e
    record_invalid(e)
  end

  protected

  def user_params
    params.require(:user).permit(:nickname, :email, :password)
  end

  def credit_card_params
    params.require(:user).permit(:source)
  end

end

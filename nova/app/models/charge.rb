# frozen_string_literal: true
require 'timeout'

class Charge < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_then: 0 }

  after_create :create_stripe_charge

  protected

  def create_stripe_charge
    Timeout.timeout(3) do
      sleep(4)
      Stripe::Charge.create(
        amount: amount,
        currency: 'jpy',
        customer: user.stripe_id
      )
    end
  rescue Stripe::StripeError => e
    errors.add(:user, e.code.to_s.to_sym)
    throw :abort
  rescue Timeout::Error => e
    errors.add(:user, e.to_s.to_sym)
    throw :abort
  end
end

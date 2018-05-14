# frozen_string_literal: true
require 'timeout'

class Charge < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_then: 0 }

  after_create :create_stripe_charge

  def is_accepted?
    not self.accepted_at.nil?
  end

  protected

  def create_stripe_charge
    Timeout.timeout(3) do
      result = Stripe::Charge.create(
        amount: amount,
        currency: 'jpy',
        customer: user.stripe_id
      )
      self.update(accepted_at: DateTime.now)
      result
    end
  rescue Stripe::StripeError => e
    errors.add(:user, e.code.to_s.to_sym)
    throw :abort
  rescue Timeout::Error => e
    errors.add(:user, e.to_s.to_sym)
    throw :abort
  end
end

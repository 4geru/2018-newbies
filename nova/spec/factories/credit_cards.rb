# frozen_string_literal: true

FactoryBot.define do
  factory :credit_card do
    user { create(:user, :with_activated) }
  end
end

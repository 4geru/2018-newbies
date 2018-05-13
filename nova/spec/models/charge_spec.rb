# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Charge, type: :model do
  describe 'validation' do
    subject(:charge) { build(:charge) }

    it { is_expected.to be_valid }

    # [TODO] amount: -1のテスト
  end

  describe 'accepted_at' do
    context 'charge accepted_at is null' do
      let(:charge) { build(:charge) }
      it { expect(charge.accepted_at).to eq nil }
      it { expect(charge.is_accepted?).to eq false }
    end

    context 'charge accepted_at is null' do
      let(:date_time) { DateTime.new(2018,6,1) }
      let(:charge) { build(:charge, accepted_at: date_time) }
      it { expect(charge.accepted_at).to eq date_time }
      it { expect(charge.is_accepted?).to eq true }
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    subject { get :show }

    context 'without logged in' do
      it { is_expected.to redirect_to(login_path) }
    end

    context 'with logged in' do
      before { login!(user) }

      it.pending { is_expected.to have_http_status(200) }
    end

    context 'with activate' do
      let(:user) { create(:user, :with_activated) }

      it.pending { is_expected.to have_http_status(200) }
    end
  end
end

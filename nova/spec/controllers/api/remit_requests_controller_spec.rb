# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::RemitRequestsController, type: :controller do
  let(:user) { create(:user, :with_activated) }
  let(:target) { create(:user, :with_activated) }
  let(:remit_request) { create(:remit_request, target: user) }

  describe 'GET #index' do
    context 'without page params' do
      subject { get :index }

      context 'without logged in' do
        it { is_expected.to have_http_status(:unauthorized) }
      end

      context 'with logged in' do
        before { login!(user) }

        it { is_expected.to have_http_status(:ok) }
      end
    end

    context 'with page params' do
      subject { get :index, params: { pages: 1 } }

      context 'without logged in' do
        it { is_expected.to have_http_status(:unauthorized) }
      end

      context 'with logged in' do
        before { login!(user) }

        it { is_expected.to have_http_status(:ok) }
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { emails: [target.email], amount: 3000 } }

    context 'without logged in' do
      it { is_expected.to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      before { login!(user) }

      it { is_expected.to have_http_status(:created) }
    end
  end

  describe 'POST #accept' do
    subject { post :accept, params: { id: remit_request.id } }

    context 'without logged in' do
      it { is_expected.to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      before { login!(user) }

      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'POST #reject' do
    subject { post :reject, params: { id: remit_request.id } }

    context 'without logged in' do
      it { is_expected.to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      before { login!(user) }

      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'POST #cancel' do
    subject { post :cancel, params: { id: remit_request.id } }

    context 'without logged in' do
      it { is_expected.to have_http_status(:unauthorized) }
    end

    context 'with logged in' do
      before { login!(user) }

      it { is_expected.to have_http_status(:ok) }
    end
  end
end

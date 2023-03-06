# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VacationPeriods', type: :request do
  let!(:collaborator) { create(:collaborator) }

  describe 'GET /index' do
    it 'returns http success' do
      get '/vacation_periods/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:start_date) { DateTime.now }
    let(:end_date) { start_date + 10.days }
    let(:params) do
      {
        start_date: start_date,
        end_date: end_date,
        collaborator_id: collaborator.id
      }
    end

    it 'returns http success' do
      # expect(Vacations::AssignService).to receive(:call)

      post('/vacation_periods/create', params: params)

      # expect(response).to have_http_status(:success)
    end
  end
end

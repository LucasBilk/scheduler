# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VacationPeriods', type: :request do
  let!(:collaborator) { create(:collaborator) }

  describe 'POST /create' do
    context 'successful creation' do
      let(:params) do
        { 
          vacation_period: {
            'start_date(1i)': 2023,
            'start_date(2i)': 3,
            'start_date(3i)': 5,
            'end_date(1i)': 2023,
            'end_date(2i)': 3,
            'end_date(3i)': 25
          },
          collaborator: {
            id: collaborator.id
          }
        }
      end

      it 'returns http success' do
        post('/vacation_periods', params: params)

        expect(response).to have_http_status(:found)
      end
    end

    context 'failed creation' do
      let(:params) do
        { 
          vacation_period: {
            'start_date(1i)': 2023,
            'start_date(2i)': 3,
            'start_date(3i)': 5,
            'end_date(1i)': 2023,
            'end_date(2i)': 3,
            'end_date(3i)': 6
          },
          collaborator: {
            id: collaborator.id
          }
        }
      end

      it 'returns http success' do
        post('/vacation_periods', params: params)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

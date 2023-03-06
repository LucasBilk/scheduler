# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vacations::AssignService', type: :service do
  let!(:collaborator) { create(:collaborator) }

  let(:start_date) { DateTime.now }
  let(:end_date) { start_date + 10.days }
  let(:params) do
    {
      start_date: start_date,
      end_date: end_date,
      collaborator_id: collaborator.id
    }
  end

  let(:service_klass) { Vacations::AssignService }

  subject { service_klass.call(params) }

  describe '#call' do
    context 'successful validation' do
      it 'persists a vacation object for the collaborator' do
        subject 

        collaborator.reload

        expect(collaborator.vacation_periods).not_to be(nil)

        vacation_period = collaborator.vacation_periods.first

        expect(vacation_period.start_date.to_i).to eq(start_date.to_i)
        expect(vacation_period.end_date.to_i).to eq(end_date.to_i)
      end
    end

    context 'failed validation' do
      let(:end_date) { start_date + 2.days }

      it 'does not persist a vacation object for the collaborator' do
        subject 

        collaborator.reload

        expect(collaborator.vacation_periods.empty?).to be(true)
      end
    end
  end
end
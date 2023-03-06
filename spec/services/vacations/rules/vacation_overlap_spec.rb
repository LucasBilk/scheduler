# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vacations::Rules::VacationOverlap' do
  let!(:collaborator) { create(:collaborator) }
  let!(:previous_vacation_1) do
    create(:vacation_period, start_date: (DateTime.now - 7.months), end_date: (DateTime.now - 5.months),
                             collaborator: collaborator)
  end
  let!(:previous_vacation_2) do
    create(:vacation_period, start_date: (DateTime.now - 2.months), end_date: (DateTime.now - 1.months),
                             collaborator: collaborator)
  end

  let(:start_date) { DateTime.now }
  let(:end_date) { start_date + 10.days }
  let(:params) do
    {
      start_date: start_date,
      end_date: end_date,
      collaborator_id: collaborator.id
    }
  end

  let(:rule_klass) { Vacations::Rules::VacationOverlap }
  let(:service_klass) { Vacations::AssignService }
  let(:entity) { service_klass.new(params) }

  subject { rule_klass.new(entity).verify! }

  describe 'rules validations' do
    before do
      entity.fetch_collaborator
      entity.initialize_vacation_period
    end

    context 'successful validation' do
      it 'returns true for proper values' do
        expect(subject).to eq(true)
      end
    end

    context 'failed validation' do
      let(:start_date) { DateTime.now - 6.months }

      it 'returns false for invalid balance' do
        expect(subject).to eq(false)
      end
    end
  end
end

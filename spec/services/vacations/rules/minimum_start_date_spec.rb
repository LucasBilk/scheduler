# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vacations::Rules::MinimumStartDate' do
  let(:contract_date) { DateTime.now - 24.months }
  let!(:collaborator) { create(:collaborator, contract_date: contract_date) }

  let(:start_date) { DateTime.now }
  let(:end_date) { start_date + 10.days }
  let(:params) do
    {
      start_date: start_date,
      end_date: end_date,
      collaborator_id: collaborator.id
    }
  end

  let(:rule_klass) { Vacations::Rules::MinimumStartDate }
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
      let(:contract_date) { DateTime.now - 6.months }
      let!(:collaborator) { create(:collaborator, contract_date: contract_date) }

      it 'returns false for invalid balance' do
        expect(subject).to eq(false)
      end
    end
  end
end

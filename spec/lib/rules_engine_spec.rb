# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RulesEngine' do
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
  let(:entity) { service_klass.new(params) }

  subject { RulesEngine.verify!(entity) }

  describe 'rules validations' do
    before do
      entity.fetch_collaborator
      entity.initialize_vacation_period
    end

    context 'successful validation' do
      it 'returns a hash with proper attributes for each rule' do
        response = subject

        expect(response.keys).to eq(entity.class::RULES)
        expect(response.values.all?).to eq(true)
      end
    end

    context 'failed validation' do
      let(:contract_date) { DateTime.now - 5.days }
      let!(:collaborator) { create(:collaborator, contract_date: contract_date) }
      let(:end_date) { start_date + 2.days }


      it 'returns a hash with proper attributes for each failed rule' do
        response = subject

        expect(response.keys).to eq(entity.class::RULES)

        expect(response[:collaborator_vacation_balance]).to eq(false)
        expect(response[:minimum_start_date]).to eq(false)
        expect(response[:vacation_overlap]).to eq(true)
        expect(response[:minimum_duration]).to eq(false)
      end
    end
  end
end

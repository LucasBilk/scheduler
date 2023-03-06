# frozen_string_literal: true

module Vacations
  module Rules
    class CollaboratorVacationBalance < BaseRule
      def verify!
        collaborator = entity.collaborator

        contract_date = collaborator.contract_date.to_datetime
        working_days = (DateTime.now.to_datetime - contract_date).to_i
        working_months = (working_days / 365) * 12

        total_vacation_balance = 30 * working_months

        previous_vacations_balance = collaborator.vacation_periods.map(&:period_in_days).sum

        available_balance = total_vacation_balance - previous_vacations_balance

        available_balance.positive?
      end
    end
  end
end

# frozen_string_literal: true

module Vacations
  module Rules
    class MinimumStartDate < BaseRule
      def verify!
        collaborator = entity.collaborator
        vacation_period = entity.vacation_period

        contract_date = collaborator.contract_date.to_datetime
        start_date = vacation_period.start_date.to_datetime

        started_since_in_days = (start_date - contract_date).to_i
        started_since_in_years = (started_since_in_days / 365) * 12

        started_since_in_years > 12
      end
    end
  end
end

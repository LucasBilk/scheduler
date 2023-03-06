# frozen_string_literal: true

module Vacations
  module Rules
    class VacationOverlap < BaseRule
      def verify!
        collaborator = entity.collaborator
        vacation_period = entity.vacation_period

        start_date = vacation_period.start_date.to_datetime
        end_date = vacation_period.end_date.to_datetime

        previous_vacations = collaborator.vacation_periods

        validations = previous_vacations.map do |previous_vacation|
          next unless previous_vacation.persisted?

          previous_vacation_start_date = previous_vacation.start_date.to_datetime
          previous_vacation_end_date = previous_vacation.end_date.to_datetime

          start_validation = start_date.between?(previous_vacation_start_date, previous_vacation_end_date)
          end_validation = end_date.between?(previous_vacation_start_date, previous_vacation_end_date)

          # neither the start date nor the end date can be in bewtween previous vacations dates
          start_validation && end_validation
        end

        # expect to not have any date in between previous vacations
        validations.none?
      end
    end
  end
end

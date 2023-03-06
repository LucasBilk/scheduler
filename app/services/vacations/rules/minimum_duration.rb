# frozen_string_literal: true

module Vacations
  module Rules
    class MinimumDuration < BaseRule
      def verify!
        vacation_period = entity.vacation_period

        start_date = vacation_period.start_date.to_datetime
        end_date = vacation_period.end_date.to_datetime

        period = end_date - start_date

        period >= 10
      end
    end
  end
end

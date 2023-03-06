# frozen_string_literal: true

json.array! @vacation_periods, partial: 'vacation_periods/vacation_period', as: :vacation_period

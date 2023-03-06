# frozen_string_literal: true

json.extract! vacation_period, :id, :start_date, :end_date, :collaborator_id, :created_at, :updated_at
json.url vacation_period_url(vacation_period, format: :json)

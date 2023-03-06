# frozen_string_literal: true

json.extract! collaborator, :id, :name, :role, :contract_date, :created_at, :updated_at
json.url collaborator_url(collaborator, format: :json)

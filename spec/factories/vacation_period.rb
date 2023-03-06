# frozen_string_literal: true

FactoryBot.define do
  factory :vacation_period do
    collaborator
    start_date { Date.today - rand(10_000) }
    end_date { Date.today + rand(10_000) }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :collaborator do
    name { Faker::Name.name }
    role { Faker::Job.title }
    contract_date { Date.today - rand(10_000) }

    factory :collaborator_with_vacation do
      after(:create) do |collaborator|
        create(:vacation_period, collaborator: collaborator)
      end
    end
  end
end

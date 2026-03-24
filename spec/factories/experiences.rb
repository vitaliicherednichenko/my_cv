# frozen_string_literal: true

FactoryBot.define do
  factory :experience do
    company_name { 'Test Company' }
    position { 'Developer' }
    location { 'Remote' }
    start_date { Date.new(2022, 1) }
    end_date { Date.new(2023, 1) }
    current { false }

    association :profile
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :education do
    institution { 'Test University' }
    degree { 'Computer Science' }
    location { 'Test City' }
    start_date { Date.new(2020, 1) }
    end_date { Date.new(2024, 1) }
    association :profile
  end
end

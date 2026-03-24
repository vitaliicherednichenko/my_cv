# frozen_string_literal: true

FactoryBot.define do
  factory :certificate do
    name { 'Ruby on Rails' }
    provider { 'Test Provider' }
    issue_date { Time.zone.today }
    association :profile
  end
end

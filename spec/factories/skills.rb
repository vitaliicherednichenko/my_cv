# frozen_string_literal: true

FactoryBot.define do
  factory :skill do
    name { 'Ruby' }
    level { 90 }
    category { 'backend' }

    association :profile
  end
end

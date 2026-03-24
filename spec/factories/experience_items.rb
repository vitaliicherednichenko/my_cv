# frozen_string_literal: true

FactoryBot.define do
  factory :experience_item do
    content { 'Did something important' }
    association :experience
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    name { 'English' }
    level { 'B2' }
    association :profile
  end
end

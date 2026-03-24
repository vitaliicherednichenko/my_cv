# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'Ruby' }
    github_url { 'vi4me' }
    description { 'backend' }

    association :profile
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    full_name { 'Vitalii Cherednichenko' }
    title { 'Ruby on Rails Developer' }
    email { 'test@example.com' }
    phone { '+123456789' }
    location { 'Remote' }
  end
end

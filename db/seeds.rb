# frozen_string_literal: true

User.destroy_all
ExperienceItem.destroy_all
Experience.destroy_all
Skill.destroy_all
Language.destroy_all
Education.destroy_all
Certificate.destroy_all
Project.destroy_all
Profile.destroy_all

User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Dir.glob(Rails.root.join("db/seeds/**/*.rb")).sort.each do |file|
  require file
end

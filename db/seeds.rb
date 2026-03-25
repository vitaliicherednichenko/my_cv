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

profile = Profile.create!(
  full_name: 'Vitalii Cherednichenko',
  title: 'Ruby on Rails Developer',
  email: 'vitaliy.cherednichenko113@gmail.com',
  phone: '+34 613 967 674',
  location: 'Seville, Spain',
  github_url: 'https://github.com/vitaliicherednichenko',
  linkedin_url: 'https://www.linkedin.com/in/vitalii-cherednichenko',
  summary: 'Ruby on Rails developer with 5+ years of experience.' \
    ' Skilled in building scalable web applications, APIs, and e-commerce systems.'
)

exp_yes = profile.experiences.create!(
  company_name: 'YES Jewellery',
  position: 'Ruby on Rails Developer',
  location: 'Gdansk, Poland',
  start_date: Date.new(2021, 9),
  end_date: Date.new(2024, 2),
  current: false
)

[
  'Designing and developing REST APIs (JSON)',
  'Working with Spree e-commerce platform',
  'Integrating external tools and services',
  'Fixing errors from Sentry',
  'Working with AWS, Redis, Elasticsearch, MongoDB',
  'Using RabbitMQ queues',
  'Improving code quality with Rubocop and CI',
  'Creating Docker environments'
].each do |item|
  exp_yes.experience_items.create!(content: item)
end

exp_xebia = profile.experiences.create!(
  company_name: 'Xebia',
  position: 'Ruby on Rails Developer',
  location: 'Gdansk, Poland',
  start_date: Date.new(2021, 6),
  end_date: Date.new(2021, 9),
  current: false
)

[
  'Refactoring legacy code',
  'Writing RSpec tests',
  'Fixing bugs',
  'Mentoring junior developers',
  'Working with international clients'
].each do |item|
  exp_xebia.experience_items.create!(content: item)
end

exp_you = profile.experiences.create!(
  company_name: 'You are launched',
  position: 'Ruby on Rails Developer',
  location: 'Kharkiv, Ukraine',
  start_date: Date.new(2021, 4),
  end_date: Date.new(2021, 6),
  current: false
)

[
  'Refactoring code',
  'Fixing bugs',
  'Writing tests',
  'Adding translations',
  'Creating authorization'
].each do |item|
  exp_you.experience_items.create!(content: item)
end

exp_fh_front = profile.experiences.create!(
  company_name: 'FreelanceHunt',
  position: 'Frontend Developer',
  location: 'Kharkiv, Ukraine',
  start_date: Date.new(2020, 7),
  end_date: Date.new(2020, 8),
  current: false
)

[
  'Building multi-page e-commerce website',
  'Working with cloud image storage',
  'Deploying application to Heroku'
].each do |item|
  exp_fh_front.experience_items.create!(content: item)
end

exp_upwork = profile.experiences.create!(
  company_name: 'Upwork',
  position: 'Python Developer',
  location: 'Remote',
  start_date: Date.new(2020, 4),
  end_date: Date.new(2020, 12),
  current: false
)

[
  'Building web scrapers',
  'Collecting data from 100+ sources',
  'Creating data visualization tools'
].each do |item|
  exp_upwork.experience_items.create!(content: item)
end

[
  ['Ruby', 90],
  ['Ruby on Rails', 90],
  ['PostgreSQL', 90],
  ['RSpec', 90],
  ['Docker', 90],
  ['MySQL', 80],
  ['JavaScript', 80],
  ['HTML/CSS', 80],
  ['Bash', 80]
].each do |name, level|
  Skill.create!(name: name, level: level, category: 'backend', profile: profile)
end

[
  %w[English B2],
  %w[Polish B2],
  %w[Ukrainian Native],
  %w[Russian Native]
].each do |name, level|
  Language.create!(name: name, level: level, profile: profile)
end

Education.create!(
  institution: 'Kharkiv State University of Food Technology and Trade',
  degree: 'Merchandising',
  location: 'Kharkiv, Ukraine',
  profile: profile,
  start_date: Date.new(2001, 9),
  end_date: Date.new(2006, 7)
)

Certificate.create!(
  name: 'Ruby on Rails',
  provider: 'Spalah',
  profile: profile,
  issue_date: Date.new(2017, 5)
)

Certificate.create!(
  name: 'HTML, Ruby, SQL',
  provider: 'SoloLearn',
  profile: profile,
  issue_date: Date.new(2017, 7)
)

Certificate.create!(
  name: 'Ruby Developer',
  provider: 'SoloLearn',
  profile: profile,
  issue_date: Date.new(2017, 12)
)

Project.create!(
  name: 'E-commerce Platform (Spree)',
  description: 'Custom e-commerce platform with integrations and API support.',
  profile: profile,
  github_url: 'https://github.com/vitaliicherednichenko'
)

Project.create!(
  name: 'COVID Data Scraper',
  description: 'Python scraper collecting data from 100+ sources.',
  profile: profile,
  github_url: 'https://github.com/vitaliicherednichenko'
)

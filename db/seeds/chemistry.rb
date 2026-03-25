# frozen_string_literal: true

profile = Profile.create!(
  full_name: 'C. V. Chemistry',
  title: 'Chemistry Student / Research Assistant',
  email: 'cvchemi@ncsu.edu',
  phone: '333.123.4567',
  location: 'Raleigh, NC, USA',
  linkedin_url: 'https://www.linkedin.com/in/cvchemi',
  summary: 'Highly motivated chemistry student with strong research experience in mass spectrometry imaging and analytical chemistry techniques.'
)

exp_research = profile.experiences.create!(
  company_name: 'North Carolina State University - Department of Chemistry',
  position: 'Undergraduate Research Assistant',
  location: 'Raleigh, NC, USA',
  start_date: Date.new(2020, 1), # приблизительно
  current: true
)

[
  'Developing standard system suitability testing (SST) protocols',
  'Ensuring optimal instrument conditions before sample analysis',
  'Working with mass spectrometry imaging (MSI)',
  'Using IR-MALDESI ionization techniques',
  'Collaborating within Muddiman Research Group'
].each do |item|
  exp_research.experience_items.create!(content: item)
end

exp_alpha = profile.experiences.create!(
  company_name: 'Alpha Chi Sigma Professional Chemistry Fraternity',
  position: 'President',
  location: 'Raleigh, NC, USA',
  start_date: Date.new(2022, 5),
  current: true
)

[
  'Led organization of 40+ members',
  'Delegated bi-weekly action items to board members',
  'Acted as main contact with university and national chapter',
  'Improved internal documentation and communication processes'
].each do |item|
  exp_alpha.experience_items.create!(content: item)
end

exp_treasurer = profile.experiences.create!(
  company_name: 'Alpha Chi Sigma Professional Chemistry Fraternity',
  position: 'Treasurer',
  location: 'Raleigh, NC, USA',
  start_date: Date.new(2021, 5),
  end_date: Date.new(2022, 4),
  current: false
)

[
  'Managed financial accounts and tax documentation',
  'Planned annual budgets',
  'Organized fundraising activities'
].each do |item|
  exp_treasurer.experience_items.create!(content: item)
end

exp_ambassador = profile.experiences.create!(
  company_name: 'NC State University - College of Sciences',
  position: 'Ambassador',
  location: 'Raleigh, NC, USA',
  start_date: Date.new(2021, 1),
  current: true
)

[
  'Participated in recruitment events for prospective students',
  'Created video content about student experience',
  'Represented Chemistry Department at events',
  'Advised incoming students on academic paths'
].each do |item|
  exp_ambassador.experience_items.create!(content: item)
end

[
  ['Orbitrap Mass Spectrometry (Exploris 240)', 85],
  ['IR-MALDESI Ionization', 85],
  ['TM-Sprayer Operation', 75],
  ['Origin (Graphing)', 80],
  ['UV-Vis Spectroscopy', 85],
  ['HPLC', 85],
  ['MSiReader', 75],
  ['CorelDraw', 70]
].each do |name, level|
  Skill.create!(name: name, level: level, category: 'chemistry', profile: profile)
end

Education.create!(
  institution: 'North Carolina State University',
  degree: 'B.S. Chemistry (Minor in Biological Sciences)',
  location: 'Raleigh, NC, USA',
  profile: profile,
  start_date: Date.new(2019, 9), # приблизительно
  end_date: Date.new(2024, 5)
)

Project.create!(
  name: 'Statistical Approach to System Suitability Testing for MSI',
  description: 'Research on SST protocols for IR-MALDESI mass spectrometry imaging. Manuscript in preparation for Journal of the American Society for Mass Spectrometry.',
  profile: profile
)
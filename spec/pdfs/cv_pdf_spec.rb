# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CvPdf do
  let(:profile) { create(:profile, full_name: 'John Doe', title: 'Developer') }

  before do
    create(:skill, profile: profile, name: 'Ruby', level: 80)
    create(:language, profile: profile, name: 'English', level: 'Fluent')
    create(:education, profile: profile, degree: 'BSc Computer Science', start_date: 5.years.ago, end_date: 1.year.ago)
    create(:experience, profile: profile, position: 'Backend Developer', start_date: 3.years.ago, current: true)
    create(:experience_item, experience: profile.experiences.first, content: 'Built API endpoints')
    create(:certificate, profile: profile, name: 'AWS Certified', provider: 'Amazon', issue_date: 2.years.ago)

    allow_any_instance_of(CvPdf).to receive(:setup_fonts)
    allow_any_instance_of(CvPdf).to receive(:icon_text)
  end

  describe '#initialize' do
    it 'creates a CvPdf without errors' do
      expect { CvPdf.new(profile) }.not_to raise_error
    end

    it 'generates a non-empty PDF' do
      pdf = CvPdf.new(profile)

      expect(pdf.render).not_to be_empty
    end
  end

  describe '#date_range' do
    it 'returns Present for current experiences' do
      exp = profile.experiences.first

      expect(CvPdf.new(profile).date_range(exp)).to include('Present')
    end

    it 'returns formatted end date for past experiences' do
      exp = create(:experience, profile: profile, start_date: 4.years.ago, end_date: 3.years.ago, current: false)
      result = CvPdf.new(profile).date_range(exp)

      expect(result).to match(/\d{4}/)
    end
  end

  describe 'layout methods' do
    it 'calls draw_header, draw_sidebar and draw_main' do
      pdf = CvPdf.new(profile)

      expect(pdf).to respond_to(:draw_header)
      expect(pdf).to respond_to(:draw_sidebar)
      expect(pdf).to respond_to(:draw_main)
    end
  end
end

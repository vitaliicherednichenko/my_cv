# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Education, type: :model do
  describe 'associations' do
    it 'belongs to profile' do
      expect(described_class.reflect_on_association(:profile).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:education)).to be_valid
    end

    it 'is invalid without institution' do
      education = build(:education, institution: nil)

      expect(education).not_to be_valid
      expect(education.errors[:institution]).to include("can't be blank")
    end

    it 'is invalid without profile' do
      education = build(:education, profile: nil)

      expect(education).not_to be_valid
    end
  end
end

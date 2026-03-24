# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:experiences) }
    it { is_expected.to have_many(:educations) }
    it { is_expected.to have_many(:skills) }
    it { is_expected.to have_many(:languages) }
    it { is_expected.to have_many(:certificates) }
    it { is_expected.to have_many(:projects) }

    it 'destroys associated experiences' do
      profile = create(:profile)
      create(:experience, profile: profile)

      expect { profile.destroy }.to change { Experience.count }.by(-1)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:title) }
  end
end

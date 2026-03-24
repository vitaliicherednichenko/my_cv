# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
    it { is_expected.to have_many(:experience_items).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:company_name) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:start_date) }
  end

  describe 'nested attributes' do
    it 'allows creating experience_items via nested attributes' do
      experience = build(:experience, experience_items_attributes: [{ content: 'Did something cool' }])

      expect(experience).to be_valid
      expect(experience.experience_items.size).to eq(1)
    end

    it 'allows destroying nested experience_items' do
      experience = create(:experience)
      item = create(:experience_item, experience: experience)

      experience.update(experience_items_attributes: [{ id: item.id, _destroy: true }])

      expect(experience.experience_items).to be_empty
    end
  end

  describe 'dependent destroy' do
    it 'destroys associated experience_items' do
      experience = create(:experience)
      create(:experience_item, experience: experience)

      expect { experience.destroy }.to change { ExperienceItem.count }.by(-1)
    end
  end
end

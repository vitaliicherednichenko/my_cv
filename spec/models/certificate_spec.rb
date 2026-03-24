# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:certificate)).to be_valid
    end

    it 'is invalid without name' do
      certificate = build(:certificate, name: nil)
      expect(certificate).not_to be_valid
      expect(certificate.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without provider' do
      certificate = build(:certificate, provider: nil)
      expect(certificate).not_to be_valid
      expect(certificate.errors[:provider]).to include("can't be blank")
    end
  end
end

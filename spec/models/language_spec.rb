# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:level) }
  end
end

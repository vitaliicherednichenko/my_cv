# frozen_string_literal: true

class Language < ApplicationRecord
  belongs_to :profile

  LEVELS = %w[A1 A2 B1 B2 C1 C2 Native].freeze

  validates :name, :level, presence: true
end

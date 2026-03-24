# frozen_string_literal: true

class Language < ApplicationRecord
  belongs_to :profile

  validates :name, :level, presence: true
end

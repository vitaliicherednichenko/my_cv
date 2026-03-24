# frozen_string_literal: true

class ExperienceItem < ApplicationRecord
  belongs_to :experience

  validates :content, presence: true
end

# frozen_string_literal: true

class Skill < ApplicationRecord
  belongs_to :profile

  validates :name, :level, presence: true
end

# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :projects, dependent: :destroy

  accepts_nested_attributes_for :skills, allow_destroy: true
  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :languages, allow_destroy: true
  accepts_nested_attributes_for :educations, allow_destroy: true
  accepts_nested_attributes_for :certificates, allow_destroy: true
  accepts_nested_attributes_for :projects, allow_destroy: true

  validates :full_name, :title, presence: true
  # validate :skills_count_within_limit

  private

  def skills_count_within_limit
    return unless skills.size > 10

    errors.add(:skills, 'maximum 10 skills allowed')
  end
end

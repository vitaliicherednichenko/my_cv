# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :projects, dependent: :destroy

  has_one :header_style, dependent: :destroy
  has_one :sidebar_style, dependent: :destroy
  has_one :main_style, dependent: :destroy

  accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :languages, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :educations, allow_destroy: true
  accepts_nested_attributes_for :certificates, allow_destroy: true
  accepts_nested_attributes_for :projects, allow_destroy: true
  accepts_nested_attributes_for :header_style, allow_destroy: true
  accepts_nested_attributes_for :sidebar_style, allow_destroy: true
  accepts_nested_attributes_for :main_style, allow_destroy: true

  validates :full_name, :title, presence: true
  # validate :skills_count_within_limit

  after_create :build_default_styles

  private

  def skills_count_within_limit
    return unless skills.size > 10

    errors.add(:skills, 'maximum 10 skills allowed')
  end

  def build_default_styles
    create_header_style(bg_color: '#555555', text_color: '#FFFFFF', font: 'Roboto', font_size: 22, bold: true)
    create_sidebar_style(bg_color: '#325e7e', text_color: '#FFFFFF', font: 'Roboto', font_size: 10, bold: true,
                         width: 200)
    create_main_style(bg_color: '#FFFFFF', text_color: '#555555', font: 'Roboto', font_size: 11, bold: false)
  end
end

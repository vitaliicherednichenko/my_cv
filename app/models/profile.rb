# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :educations
  has_many :skills
  has_many :languages
  has_many :certificates
  has_many :projects

  validates :full_name, :title, presence: true
end

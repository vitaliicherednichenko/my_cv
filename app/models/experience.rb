# frozen_string_literal: true

class Experience < ApplicationRecord
  belongs_to :profile
  has_many :experience_items, dependent: :destroy
  accepts_nested_attributes_for :experience_items, allow_destroy: true

  validates :company_name, :position, :location, :start_date, presence: true
end

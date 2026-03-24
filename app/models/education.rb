# frozen_string_literal: true

class Education < ApplicationRecord
  belongs_to :profile

  validates :institution, presence: true
end

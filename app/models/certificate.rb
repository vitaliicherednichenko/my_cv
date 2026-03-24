# frozen_string_literal: true

class Certificate < ApplicationRecord
  belongs_to :profile

  validates :name, :provider, presence: true
end

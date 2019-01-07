# frozen_string_literal: true

class Printfile < ApplicationRecord
  validates :width, presence: true
  validates :height, presence: true
end

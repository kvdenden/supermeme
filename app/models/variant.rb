# frozen_string_literal: true

class Variant < ApplicationRecord
  has_many :fulfiller_variants, dependent: :destroy
  has_many :fulfillers, through: :fulfiller_variants
  belongs_to :product

  validates :color, presence: true
  validates :size, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

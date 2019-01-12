# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :fulfiller_products, dependent: :destroy
  has_many :fulfillers, through: :fulfiller_products
  has_many :variants

  validates :title, presence: true
  validates :description, presence: true
end

class FulfillerVariant < ApplicationRecord
  belongs_to :fulfiller
  belongs_to :variant
  belongs_to :printfile

  validates :sku, presence: true
  validates :sku, uniqueness: { scope: :fulfiller_id }
end

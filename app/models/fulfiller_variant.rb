class FulfillerVariant < ApplicationRecord
  belongs_to :fulfiller
  belongs_to :variant
  belongs_to :printfile

  validates :external_id, presence: true
  validates :external_id, uniqueness: { scope: :fulfiller_id }
end

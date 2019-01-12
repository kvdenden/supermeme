class FulfillerProduct < ApplicationRecord
  belongs_to :fulfiller
  belongs_to :product

  validates :external_id, presence: true
  validates :external_id, uniqueness: { scope: :fulfiller_id }
end

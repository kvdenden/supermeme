class PurchaseOrder < ApplicationRecord
  belongs_to :address, optional: true
  has_many :line_items
end

class PurchaseOrder < ApplicationRecord
  belongs_to :address
  has_many :line_items
end

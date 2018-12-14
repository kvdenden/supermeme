class PurchaseOrder < ApplicationRecord
  belongs_to :address, optional: true
  has_many :line_items

  accepts_nested_attributes_for :address
end

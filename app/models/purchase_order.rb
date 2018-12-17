class PurchaseOrder < ApplicationRecord
  belongs_to :address, optional: true
  has_many :line_items

  accepts_nested_attributes_for :address

  def price
    line_items.sum(&:price) + shipping_fee
  end

  def price_in_cents
    (price * 100).to_i
  end

  def item_count
    line_items.sum(&:quantity)
  end

  def shipping_fee
    item_count > 0 ? 10 + (item_count - 1) * 2 : 0
  end
end

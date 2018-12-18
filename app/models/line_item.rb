class LineItem < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :variant

  def price
    variant.price * quantity
  end
end

class LineItem < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :variant

  validates :text, presence: true
  validates :generator, presence: true
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :update_price

  def title
    "\"#{text}\" #{variant.color} #{variant.product.title}, #{variant.size}"
  end

  private

  def update_price
    if variant
      self.unit_price = variant.price
      self.price = self.unit_price * quantity
    end
  end
end

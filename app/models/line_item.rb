class LineItem < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :variant

  validates :text, presence: true
  validates :generator, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :update_price

  private

  def update_price
    if variant
      self.price = variant.price * quantity
    end
  end
end

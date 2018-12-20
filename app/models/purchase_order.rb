class PurchaseOrder < ApplicationRecord
  belongs_to :address
  has_many :line_items

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :line_items, presence: true
  validates :shipping_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_create :set_shipping_fee

  def total
    subtotal + shipping_fee
  end

  def subtotal
    line_items.sum(&:price)
  end

  def total_in_cents
    (total * 100).to_i
  end

  def item_count
    line_items.sum(&:quantity)
  end

  def empty?
    item_count.zero?
  end

  private

  def set_shipping_fee
    self.shipping_fee = 10
  end
end

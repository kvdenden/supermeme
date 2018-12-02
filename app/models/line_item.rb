class LineItem < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :variant
end

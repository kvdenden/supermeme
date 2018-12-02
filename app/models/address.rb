class Address < ApplicationRecord
  has_one :purchase_order
end

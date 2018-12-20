class AddShippingFeeToPurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_orders, :shipping_fee, :decimal
  end
end

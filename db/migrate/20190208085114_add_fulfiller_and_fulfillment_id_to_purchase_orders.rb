class AddFulfillerAndFulfillmentIdToPurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchase_orders, :fulfiller, foreign_key: true
    add_column :purchase_orders, :fulfillment_id, :string
  end
end

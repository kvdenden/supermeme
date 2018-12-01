class CreatePurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_orders do |t|
      t.string :status
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end

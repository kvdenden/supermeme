class AddContactInfoToPurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_orders, :name, :string
    add_column :purchase_orders, :email, :string
  end
end

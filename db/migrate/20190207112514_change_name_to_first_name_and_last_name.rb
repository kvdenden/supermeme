class ChangeNameToFirstNameAndLastName < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_orders, :first_name, :string
    add_column :purchase_orders, :last_name, :string
    remove_column :purchase_orders, :name, :string
  end
end

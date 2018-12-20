class AddPriceToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :price, :decimal
  end
end

class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :purchase_order, foreign_key: true
      t.references :variant, foreign_key: true
      t.string :text
      t.string :generator
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end

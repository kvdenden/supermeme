class CreateFulfillerProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :fulfiller_products do |t|
      t.references :fulfiller, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :external_id

      t.timestamps
    end
    add_index :fulfiller_products, [:fulfiller_id, :external_id], unique: true
    add_index :fulfiller_products, [:fulfiller_id, :product_id], unique: true
  end
end

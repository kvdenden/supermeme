class CreateFulfillerVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :fulfiller_variants do |t|
      t.references :fulfiller, foreign_key: true
      t.references :variant, foreign_key: true
      t.references :printfile, foreign_key: true
      t.integer :external_id

      t.timestamps
    end
    add_index :fulfiller_variants, [:fulfiller_id, :external_id], unique: true
    add_index :fulfiller_variants, [:fulfiller_id, :variant_id], unique: true
  end
end

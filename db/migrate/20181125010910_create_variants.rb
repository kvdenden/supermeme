class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.integer :external_id, index: { unique: true }
      t.references :product, foreign_key: true
      t.string :color
      t.string :size
      t.decimal :price

      t.timestamps
    end
  end
end

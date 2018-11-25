class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :external_id, index: { unique: true }
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

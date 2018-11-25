class CreatePrintfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :printfiles do |t|
      t.integer :width
      t.integer :height
      t.integer :dpi

      t.timestamps
    end
  end
end

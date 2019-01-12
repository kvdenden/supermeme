class CreateFulfillers < ActiveRecord::Migration[5.2]
  def change
    create_table :fulfillers do |t|
      t.string :name

      t.timestamps
    end
  end
end

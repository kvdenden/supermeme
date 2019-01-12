class RemoveExternalIdFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :external_id
  end
end

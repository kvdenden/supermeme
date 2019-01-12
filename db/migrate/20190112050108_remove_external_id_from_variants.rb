class RemoveExternalIdFromVariants < ActiveRecord::Migration[5.2]
  def change
    remove_column :variants, :external_id, :integer
  end
end

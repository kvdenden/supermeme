class ChangeExternalIdToSkuInFulfillerVariants < ActiveRecord::Migration[5.2]
  def change
    remove_column :fulfiller_variants, :external_id, :integer
    add_column :fulfiller_variants, :sku, :string
  end
end

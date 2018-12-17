class RemoveNamesFromAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :recipient_name
    remove_column :addresses, :company_name
  end
end

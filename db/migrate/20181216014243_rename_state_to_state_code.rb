class RenameStateToStateCode < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :state, :state_code
  end
end

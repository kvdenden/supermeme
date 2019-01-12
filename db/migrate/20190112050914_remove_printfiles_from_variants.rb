class RemovePrintfilesFromVariants < ActiveRecord::Migration[5.2]
  def change
    remove_reference :variants, :printfile
  end
end

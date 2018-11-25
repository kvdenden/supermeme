class AddPrintfileToVariants < ActiveRecord::Migration[5.2]
  def change
    add_reference :variants, :printfile, foreign_key: true
  end
end

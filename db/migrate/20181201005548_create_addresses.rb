class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country_code
      t.string :recipient_name
      t.string :company_name

      t.timestamps
    end
  end
end

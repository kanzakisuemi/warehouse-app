class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :employer_identification_number
      t.string :address
      t.string :city
      t.string :cep
      t.string :email

      t.timestamps
    end
  end
end

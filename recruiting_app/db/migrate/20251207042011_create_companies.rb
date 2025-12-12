class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :url
      t.string :phone_number
      t.text :description
      t.integer :headcount
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip_code
      t.boolean :is_client

      t.timestamps
    end
  end
end

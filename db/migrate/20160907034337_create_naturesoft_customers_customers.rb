class CreateNaturesoftCustomersCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_customers_customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email
      t.string :phone
      t.references :country, index: true, references: :naturesoft_areas_countries, :null => true
      t.references :area, index: true, references: :naturesoft_areas_areas, :null => true

      t.timestamps
    end
  end
end

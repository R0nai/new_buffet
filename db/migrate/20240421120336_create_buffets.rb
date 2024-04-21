class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :brand, null: false
      t.string :corporate_name, null: false
      t.string :registration_number, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.string :district, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :zip_code, null: false
      t.string :description

      t.timestamps
    end
  end
end

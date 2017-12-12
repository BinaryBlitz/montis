class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.integer :amount, null: false
      t.integer :term, null: false
      t.string :car_model
      t.integer :car_year
      t.string :car_vin
      t.string :first_name, null: false
      t.string :last_name
      t.string :patronymic_name
      t.date :birthdate
      t.string :passport_number
      t.date :passport_date
      t.string :email
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end

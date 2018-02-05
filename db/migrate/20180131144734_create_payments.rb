class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :amount, null: false
      t.boolean :paid, default: false
      t.belongs_to :loan, foreign_key: true

      t.timestamps
    end
  end
end

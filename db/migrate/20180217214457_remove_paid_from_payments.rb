class RemovePaidFromPayments < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :paid
  end
end

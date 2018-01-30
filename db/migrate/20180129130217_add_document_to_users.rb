class AddDocumentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :document, :string
    remove_column :users, :phone_number
  end
end

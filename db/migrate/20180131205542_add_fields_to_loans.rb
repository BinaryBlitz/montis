class AddFieldsToLoans < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :sms_notifications_enabled, :boolean, default: true
    add_column :loans, :email_notifications_enabled, :boolean, default: true
    add_column :loans, :notified, :boolean, default: false
    add_column :loans, :next_date_of_payment, :datetime
    add_column :loans, :advanced_payment_requested, :boolean, default: false
  end
end

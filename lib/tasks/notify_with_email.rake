desc 'Notify with email'
task :notify_with_email do
  Loan.with_enabled_email_notifications.notifiable.each(&:notify_wth_email)
end

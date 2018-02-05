desc 'Notify with sms'
task :notify_with_sms do
  Loan.with_enabled_sms_notifications.notifiable.each(&:notify_wth_sms)
end

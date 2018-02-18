Tinkoff.configure do |config|
  config.terminal_key = Rails.application.secrets.tinkoff_terminal_key
  config.password = Rails.application.secrets.tinkoff_password
end

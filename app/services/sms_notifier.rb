class SMSNotifier
  SMS_VERIFICATION_URL = 'http://sms.ru/sms/send'
  SUCCESS_CODE = '100'

  def initialize(phone_number, content)
    @phone_number = phone_number
    @content = content
  end

  def notify
    return true if @phone_number == Rails.application.secrets.demo_phone_number

    response = HTTParty.post(SMS_VERIFICATION_URL, body: sms_params).parsed_response

    if response.lines.first.try(:chomp) == SUCCESS_CODE
      true
    else
      Rails.logger.info "#{Time.zone.now}: SMS for #{@phone_number} failed.\n#{response}"
      false
    end
  end

  private

  def sms_params
    {
      api_id: Rails.application.secrets.sms_ru_api_id,
      text: @content,
      from: Rails.application.secrets.sms_ru_sender,
      to: @phone_number
    }
  end
end

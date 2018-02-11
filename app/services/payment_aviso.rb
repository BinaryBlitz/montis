class PaymentAviso < Action
  self.action_name = 'paymentAviso'

  def response
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'

    xml.paymentAvisoResponse(
      performedDatetime: Time.current.iso8601,
      code: code,
      invoiceId: params[:invoice_id],
      shopId: shop_id
    )
    xml.target!
  end

  def payment_type
    params[:payment_type]
  end

  private

  def code
    valid_signature? ? '0' : '1'
  end
end

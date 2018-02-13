class YandexKassaAction
  PARAMS_MAP = {
    requestDatetime: :request_datetime,
    action: :action,
    md5: :md5,
    shopId: :shop_id,
    shopArticleId: :shop_article_id,
    invoiceId: :invoice_id,
    orderNumber: :payment_id,
    customerNumber: :customer_number,
    orderCreatedDatetime: :order_created_datetime,
    orderSumAmount: :order_sum_amount,
    orderSumCurrencyPaycash: :order_sum_currency_paycash,
    orderSumBankPaycash: :order_sum_bank_paycash,
    shopSumAmount: :shop_sum_amount,
    shopSumCurrencyPaycash: :shopSumCurrencyPaycash,
    shopSumBankPaycash: :shop_sum_bank_paycash,
    paymentPayerCode: :payment_payer_code,
    paymentType: :payment_type
  }
  SIGNATURE_PARAMS = [
    :order_sum_amount, :order_sum_currency_paycash, :order_sum_bank_paycash,
    :shop_id, :invoice_id, :customer_number
  ]
  VALID_CODE = '0'
  INVALID_CODE = '1'

  class_attribute :action_name, :shop_id, :password

  self.shop_id = Rails.application.secrets.yandex_kassa_id
  self.password = Rails.application.secrets.yandex_kassa_password

  attr_reader :params

  def initialize(controller_params)
    @params = map_params(controller_params)
  end

  def valid_signature?
    values = [action_name] + SIGNATURE_PARAMS.map { |name| params[name] } + [password]
    generate_signature(values) == params[:md5]
  end

  def payment
    @payment ||= Payment.find(params[:payment_id])
  end

  def response
    raise NotImplementedError
  end

  private

  def map_params(params)
    hashable_array = PARAMS_MAP.map do |param, mapped_param|
      [mapped_param, params[param]]
    end
    HashWithIndifferentAccess[hashable_array]
  end

  def generate_signature(*params)
    Digest::MD5.hexdigest(params.join(';')).upcase
  end
end

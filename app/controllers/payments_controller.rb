class PaymentsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_loan, only: [:check]

  def check
    @payment = @loan.create_payment(user: current_user)

    render text: CheckOrder.new(params).response
  end

  def aviso
    aviso = PaymentAviso.new(params).valid_signature?
    @payemnt = Payment.find(params[:orderNumber])
    @payment.paid! if aviso

    logger.debug("Payment #{@payment.id}: success callback")
    render text: aviso.response
  end

  def success
    redirect_to profile_url, notice: 'Оплата прошла успешно'
  end

  def fail
    redirect_to root_url, notice: 'Оплата не прошла'

    logger.debug(params)
    head :ok
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end

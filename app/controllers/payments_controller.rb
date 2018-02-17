class PaymentsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_loan, :set_notification, only: [:create]

  def create
    @payment = @loan.payments.build

    render plain: 'OK', status: :ok if @notification.success? && @payment.save
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def set_notification
    @notification = Tinkoff::Notification.new(params)
  end
end

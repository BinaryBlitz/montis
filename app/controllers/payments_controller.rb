class PaymentsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_loan, only: [:create]
  before_action :set_notification, only: [:notify]

  def create
    @payment = @loan.payments.build

    if @payment.save
      render js: "this.order.value=#{@payment.id};pay(this);"
    else
      redirect_to root_path, alert: 'Что-то пошло не так'
    end
  end

  def notify
    Payment.find(params[:OrderId]).paid! if @notification.success?

    render plain: 'OK', status: :ok
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def set_notification
    @notification = Tinkoff::Notification.new(params)
  end
end

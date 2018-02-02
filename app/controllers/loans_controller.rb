class LoansController < ApplicationController
  before_action :set_loan, only: [:update, :make_advanced_payment_request]

  def create
    @loan = Loan.new(loan_params)

    if @loan.save
      redirect_to root_path, notice: 'Мы с вами свяжемся в ближайшее время'
      LoanMailer.new_loan(@loan).deliver_later
    else
      redirect_to root_path, alert: 'Что-то пошло не так'
    end
  end

  def update
    if @loan.update(loan_update_params)
      redirect_to profile_path
    else
      redirect_to profile_path, alert: 'Что-то пошло не так'
    end
  end

  def make_advanced_payment_request
    if !@loan.advanced_payment_requested && @loan.update(advanced_payment_requested: true)
      redirect_to profile_path, notice: 'Заявка отправлена'
      LoanMailer.request_for_advanced_payment(@loan).deliver_later
    else
      redirect_to profile_path, alert: 'Что-то пошло не так'
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params
      .require(:loan)
      .permit(
        :amount, :term, :car_model, :car_year, :car_vin,
        :first_name, :last_name, :patronymic_name, :birthdate,
        :passport_number, :passport_date, :email, :phone_number
      )
  end

  def loan_update_params
    params.require(:loan).permit(:sms_notifications_enabled, :email_notifications_enabled)
  end
end

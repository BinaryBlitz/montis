class LoansController < ApplicationController
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
    @loan = Loan.find(params[:id])
    if @loan.update(loan_update_params)
      redirect_to profile_path
    else
      redirect_to profile_path, alert: 'Что-то пошло не так'
    end
  end

  private

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

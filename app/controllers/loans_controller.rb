class LoansController < ApplicationController
  def create
    @loan = Loan.new(loan_params)

    if @loan.save
      redirect_to root_path, notice: 'Мы с вами свяжемся в ближайшее время'
    else
      redirect_to root_path, alert: 'Что-то пошло не так'
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
end

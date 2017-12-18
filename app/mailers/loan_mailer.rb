class LoanMailer < ApplicationMailer
  default from: 'noreply@mkkmontis.ru', to: 'mkk.montis.zayavki@yandex.ru'

  def new_loan(loan)
    @loan = loan
    subject = "Новая заявка: #{@loan.full_name}"
    mail(subject: subject)
  end
end

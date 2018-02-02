class LoanMailer < ApplicationMailer
  default from: 'noreply@mkkmontis.ru', to: 'mkk.montis.zayavki@yandex.ru'

  def new_loan(loan)
    @loan = loan
    subject = "Новая заявка: #{@loan.full_name}"
    mail(subject: subject)
  end

  def date_of_payment_reminder(loan)
    @loan = loan
    subject = "Напоминание о дате платежа для займа №#{@loan.id}"
    mail(to: @loan.email, subject: subject)
  end

  def request_for_advanced_payment(loan)
    @loan = loan
    subject = "Досрочное погашение займа №#{@loan.id}"
    mail(subject: subject)
  end
end

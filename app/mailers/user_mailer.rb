class UserMailer < ApplicationMailer
  default from: 'noreply@mkkmontis.ru'

  def new_user(user, password)
    @user = user
    @password = password
    subject = 'Регистрация на сайте mkk-montis.ru'
    mail(to: @user.email, subject: subject)
  end
end

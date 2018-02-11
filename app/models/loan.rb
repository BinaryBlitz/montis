class Loan < ApplicationRecord
  MONTHLY_RATE = 0.06
  PENALTY_RATE = 0.2
  DAYS_IN_YEAR = 365

  belongs_to :user

  has_many :payments, dependent: :destroy

  before_validation :create_user, on: :create
  before_save :set_next_date_of_payment, on: :create

  validates :amount, :term, :first_name, :phone_number, presence: true
  validates :amount, :term, numericality: { greater_than: 0 }
  validates :term, numericality: { less_than_or_equal_to: 12 }

  scope :with_enabled_sms_notifications, -> { where(sms_notifications_enabled: true) }
  scope :with_enabled_email_notifications, -> { where(email_notifications_enabled: true) }

  def self.notifiable
    where('? between date(next_date_of_payment) - 5 and next_date_of_payment', Time.zone.now)
      .where(notified: false)
  end

  def full_name
    "#{last_name} #{first_name} #{patronymic_name}"
  end

  def number_of_payments_left
    term - payments.paid.count
  end

  def amount_to_pay
    amount - payments.sum(:amount)
  end

  def penalty_amount
    overdue_in_days * PENALTY_RATE / DAYS_IN_YEAR
  end

  def monthly_payment
    (amount * MONTHLY_RATE / (1 - 1 / (1 + MONTHLY_RATE) ** term)).to_i
  end

  def overdue_in_days
    ((Time.zone.now - next_date_of_payment) / 1.day).to_i
  end

  def notify_with_sms
    SMSNotifier.new(phone_number, sms_content).notify
    update_column(:notified, true)
  end

  def notify_with_email
    LoanMailer.date_of_payment_reminder(self).deliver_later
    update_column(:notified, true)
  end

  private

  def set_next_date_of_payment
    self.next_date_of_payment = 1.month.from_now
  end

  def create_user
    generated_password = Devise.friendly_token.first(8)
    user = User.find_or_create_by!(email: email) { |user| user.password = generated_password }
    self.user = user
    UserMailer.new_user(user, generated_password).deliver_later
  end

  def sms_content
    "Напомнинание о дате платежа для займа №#{id}. Дата платежа #{next_payment_date}"
  end
end

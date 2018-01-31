class Loan < ApplicationRecord
  MONTHLY_RATE = 0.06

  belongs_to :user

  has_many :payments, dependent: :destroy

  before_validation :create_user, on: :create

  validates :amount, :term, :first_name, :phone_number, presence: true
  validates :amount, :term, numericality: { greater_than: 0 }
  validates :term, numericality: { less_than_or_equal_to: 12 }

  def full_name
    "#{last_name} #{first_name} #{patronymic_name}"
  end

  def number_of_payments_left
    term - payments.paid.count
  end

  def amount_to_pay
    amount - payments.sum(:amount)
  end

  def monthly_payment
    amount * MONTHLY_RATE / (1 - 1 / (1 + MONTHLY_RATE) ** term)
  end

  def next_payment_date
    created_at + payments.paid.count.months
  end

  private

  def create_user
    generated_password = Devise.friendly_token.first(8)
    user = User.find_or_create_by!(email: email) { |user| user.password = generated_password }
    self.user = user
    UserMailer.new_user(user, generated_password).deliver_later
  end
end

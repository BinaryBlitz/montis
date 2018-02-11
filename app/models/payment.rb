class Payment < ApplicationRecord
  belongs_to :loan

  validates :amount, numericality: { greater_than: 0 }

  after_save :set_next_date_of_payment, on: :create
  before_validation :set_amount

  scope :paid, -> { where(paid: true) }

  def calculate_next_date_of_payment
    loan.payments.paid.count.months.from_now
  end

  def paid!
    return if paid?

    logger.debug("Payment #{id}: paid")

    update_column(:paid, true)
  end

  private

  def set_next_date_of_payment
    loan.update_column(:next_date_of_payment, calculate_next_date_of_payment)
  end

  def set_amount
    self.amount = loan.monthly_payment
  end
end

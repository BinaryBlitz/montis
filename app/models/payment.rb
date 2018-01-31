class Payment < ApplicationRecord
  belongs_to :loan

  validates :amount, numericality: { greater_than: 0 }

  after_save :set_next_date_of_payment

  scope :paid, -> { where(paid: true) }

  private

  def set_next_date_of_payment
    loan.update_column(:next_date_of_payment, loan.calculate_next_date_of_payment)
  end
end

class Loan < ApplicationRecord
  validates :amount, :term, :first_name, :phone_number, presence: true
  validates :amount, :term, numericality: { greater_than: 0 }
  validates :term, numericality: { less_than_or_equal_to: 12 }

  def full_name
    "#{last_name} #{first_name}"
  end
end

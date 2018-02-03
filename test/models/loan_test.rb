require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  setup do
    @loan = loans(:loan)
  end

  test 'is notifiable only once' do
    @loan.update_column(:next_date_of_payment, 2.days.from_now)
    assert Loan.notifiable.include?(@loan)

    @loan.notify_with_email
    assert Loan.notifiable.exclude?(@loan)
  end

  test 'is not notifiable' do
    @loan.update_column(:next_date_of_payment, 6.days.from_now)
    assert Loan.notifiable.exclude?(@loan)
  end
end

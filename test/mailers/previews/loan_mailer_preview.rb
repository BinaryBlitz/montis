class LoanMailerPreview < ActionMailer::Preview
  def new_loan
    LoanMailer.new_loan(Loan.first)
  end
end

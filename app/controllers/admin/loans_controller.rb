class Admin::LoansController < Admin::AdminController
  def index
    @loans = Loan.order(created_at: :desc)
  end
end

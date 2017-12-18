class Admin::LoansController < Admin::AdminController
  def index
    @loans = Loan.order(created_at: :desc)
  end

  def show
    @loan = Loan.find(params[:id])
  end
end

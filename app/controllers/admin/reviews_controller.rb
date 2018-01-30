class Admin::ReviewsController < Admin::AdminController
  before_action :set_review, only: [:edit, :update]

  def index
    @reviews = Review.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to admin_reviews_path, notice: 'Отзыв успешно обновлен'
    else
      render :edit
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:approved)
  end
end

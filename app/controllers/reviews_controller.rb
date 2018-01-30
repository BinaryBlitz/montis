class ReviewsController < ApplicationController
  def create
    @review = current_user.build_review(callback_request_params)

    if @review.save
      redirect_to profile_path, notice: 'Спасибо за отзыв'
    else
      redirect_to profile_path, alert: 'Что-то пошло не так'
    end
  end

  private

  def callback_request_params
    params.require(:review).permit(:content)
  end
end

module ApplicationHelper
  def status_for_review(review)
    review.approved ? 'Проверено' : 'Проверяется модератором'
  end
end

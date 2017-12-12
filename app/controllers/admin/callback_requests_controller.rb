class Admin::CallbackRequestsController < Admin::AdminController
  def index
    @callback_requests = CallbackRequest.order(created_at: :desc)
  end
end

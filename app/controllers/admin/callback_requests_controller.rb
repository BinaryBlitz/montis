class Admin::CallbackRequestsController < Admin::AdminController
  def index
    @callback_requests = CallbackRequest.all
  end
end

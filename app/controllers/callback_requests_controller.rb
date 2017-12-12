class CallbackRequestsController < ApplicationController
  def create
    @callback_request = CallbackRequest.new(callback_request_params)

    if @callback_request.save
      redirect_to root_path, notice: 'Мы с вами свяжемся в ближайшее время'
    else
      redirect_to root_path, alert: 'Что-то пошло не так'
    end
  end

  private

  def callback_request_params
    params.require(:callback_request).permit(:name, :phone_number)
  end
end

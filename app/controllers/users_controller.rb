class UsersController < ApplicationController
  def update
    if current_user.update(user_params)
      redirect_to profile_path
    else
      render :profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:document)
  end
end

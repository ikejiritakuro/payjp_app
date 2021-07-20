class UsersController < ApplicationController
  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to action: "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end

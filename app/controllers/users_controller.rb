class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.token = SecureRandom.uuid
    if @user.save
      render json: { id: @user.id, token: @user.token }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end

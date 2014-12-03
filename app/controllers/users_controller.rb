class UsersController < ApplicationController
  def index
    # render text: "I'm in the index action!"
    render json: User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
      json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    @user = User.update(params[:id], user_params)
    render json: @user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render text: "He has been decimated, lol."
  end

  private
  def user_params
    params.require(:user).permit(:user_name)
  end
end

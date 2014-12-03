class UsersController < ApplicationController
  def index
    # render text: "I'm in the index action!"
    render json: User.all
  end

  def create
    user = User.new(params[:user].permit(:name,:email))
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
    user = User.find(params[:id])
    user.update(params[:user].permit(:name, :email))
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render text: "He has been decimated, lol."
  end
end

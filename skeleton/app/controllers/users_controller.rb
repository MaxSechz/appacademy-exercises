class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    current_user.destroy
    redirect_to new_user_url
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
  
end

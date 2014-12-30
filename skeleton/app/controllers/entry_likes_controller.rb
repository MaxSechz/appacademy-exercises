class EntryLikesController < ApplicationController
  def create
    @entry_like = FeedFollow.new(entry_like_params)
    @entry_like.user_id = current_user.id
    if @entry_like.save
      render json: @entry_like
    else
      render json: @entry_like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @entry_like = FeedFollow.find(params[:id])
    @entry_like.destroy
    render json: @entry_like
  end


  private
  def entry_like_params
    params.require(:entry_like).permit(:entry_id)
  end
end

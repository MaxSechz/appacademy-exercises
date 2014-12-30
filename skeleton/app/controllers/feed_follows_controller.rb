class FeedFollowsController < ApplicationController
  def create
    @feed_follow = FeedFollow.new(feed_follow_params)
    @feed_follow.user_id = current_user.id
    if @feed_follow.save
      render json: @feed_follow
    else
      render json: @feed_follow.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @feed_follow = FeedFollow.find(params[:id])
    @feed_follow.destroy
    render json: @feed_follow
  end


  private
  def feed_follow_params
    params.require(:feed_follow).permit(:feed_id)
  end
end

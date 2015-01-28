class CommentsController < ApplicationController

  def index
    if params.keys.include?("user_id")
      to_render = Comment.where(commentable_id: params[:user_id], commentable_type: 'User')
    elsif params.keys.include?("contact_id")
      to_render = Comment.where(commentable_id: params[:contact_id], commentable_type: 'Contact')
    else
      to_render = "You've goofed for good."
    end
    render json: to_render
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render(
      json: comment.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    @comment = Comment.update(params[:id], comment_params)
    render json: @comment
  end

  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id,:body,:commentable_id,:commentable_type)
  end

end

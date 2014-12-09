class PostsController < ApplicationController

  before_action :verify_owner, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])

    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if !@post.nil? && @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.nil? ? ["Post not found"] : @post.errors.full_messages
      @post = Post.new(post_params)
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end

  def verify_owner
    @post = Post.find(params[:id])

    if @post.author_id != current_user.id
      flash[:errors] = ["Cannot mess with other people's posts!"]
      redirect_to post_url(@post)
    end
  end

end

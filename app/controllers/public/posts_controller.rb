class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :once_weight, :meat_image)
  end

end

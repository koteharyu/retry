class PostsController < ApplicationController

  skip_before_action :require_login, only: %i[index]
  PER_PAGE = 15

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to root_path, success: "created a post"
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, success: "updated a post"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to root_path, success: "deleted a post"
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end
end

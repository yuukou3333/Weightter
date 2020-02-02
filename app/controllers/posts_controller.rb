class PostsController < ApplicationController
  before_action :set_post,only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(flash[:post])
  end

  def create
    @post = Post.new(post_params)
    if post.save
      flash[:notice] = "「#{@post.title}」を投稿しました"
      redirect_to post
    else
      redirect_to :back, flash: {
        post: post,
        error_messages: post.errors.full_messages
      }
    end
  end

  def show
  end

  def edit
    @post.attributes = flash[:post] if flash[:post]
  end

  def update
    if @post.update(post_params)
      redirect_to post
    else
      redirect_to :back, flash: {
        post: post,
        error_messages: @post.errors.full_messages
      }
    end
  end

  def destroy
    @post.destroy
    binding.pry
    redirect_to posts_path, flash: { notice: "「#{@post.title}」という投稿が削除されました" }
  end



  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
  def set_post
    @post = Post.find(params[:id])
  end
end
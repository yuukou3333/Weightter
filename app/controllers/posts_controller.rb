class PostsController < ApplicationController
  before_action :set_post,only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(flash[:post])
  end

  def create
    post = Post.new(post_params)
    if post.save
      flash[:notice] = "「#{post.title}」の掲示板を作成しました"
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


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
  def set_post
    @post = Post.find(params[:id])
  end
end
class PostsController < ApplicationController
  before_action :set_post,only: %i[show edit update destroy]
  before_action :authenticate_user!, only: [:show, :create,:edit,:destroy]

  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @posts = @posts.page(params[:page])
  end

  def new
    @post = Post.new(flash[:post])
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      flash[:notice] = "「#{post.title}」を投稿しました"
      redirect_to post
    else

      redirect_back fallback_location: post, flash: {
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
      redirect_to @post
    else
      redirect_back fallback_location: @post, flash: {
        post: @post,
        error_messages: @post.errors.full_messages
      }
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, flash: { notice: "「#{@post.title}」という投稿が削除されました" }
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, tag_ids: [])
  end
  def set_post
    @post = Post.find(params[:id])
  end
end
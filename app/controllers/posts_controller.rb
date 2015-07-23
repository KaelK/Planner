class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_self, only: [:destroy, :edit, :update]
  before_action :signed_in, only: [:show]

  respond_to :html

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    @replies = @post.replies
    @new_reply = Reply.new
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    # @post.user = current_user
    # @post.user_id = current_user.id
    # puts "just set the id"
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  def signed_in
    unless signed_in?
      flash[:alert] = "You must be signed in to take the requested action!"
      redirect_to posts_path and return
    end
  end

  def ensure_self
      unless signed_in? and current_user == @post.user
        flash[:alert] = "You are not allowed to take the requested action!"
        redirect_to posts_path and return
      end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :user_id, :user)
    end
end

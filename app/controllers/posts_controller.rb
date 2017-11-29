class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def index
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created"
      redirect_to current_user
    else
      flash.now[:notice] = "Could not save post"
      render current_user
    end
  end

  def destroy
    @post.destroy
    redirect_to current_user
  end


  private ########################################


  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def correct_user
    @post = current_user.posts.find(params[:id])
    redirect_to root_url if @post.nil?
  end


end

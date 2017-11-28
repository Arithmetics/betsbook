class PostsController < ApplicationController
  before_action :authenticate_user!

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


  private ########################################


  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end


end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').all
    @posts_feed = @user.posts_feed.order('created_at DESC').all
    @friend_request = FriendRequest.new
    @post = Post.new
    @like = Like.new
  end

  def index
    @friend_request = FriendRequest.new
    @users = User.all
  end


  private ############################


  def correct_user
  end

end

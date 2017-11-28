class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @friend_request = FriendRequest.new
    @post = Post.new 
  end

  def index
    @friend_request = FriendRequest.new
    @users = User.all
  end

end

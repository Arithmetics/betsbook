class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def show
    @friend_request = FriendRequest.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
  end


  def create
    @friend_request = FriendRequest.new(friend_request_params)
    @friend_request.update_attribute(:accepted, false)
    @friend_request.update_attribute(:requestor_id, current_user.id)
    if @friend_request.save
      flash[:notice] = "Friend Request Sent"
      redirect_to current_user
    else
      flash[:notice] = "There was an error when creating the friend request"
    end
  end


  def update
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.accept
      flash[:notice] = "New Friendship Created!"
      redirect_to @friend_request.requestor
    else
      flash[:notice] = "something went wrong, your friendship was not created"
      redirect_to root_path
    end
  end


  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    flash[:notice] = "Friendship DESTROYED!"
    redirect_to current_user
  end


  private ####################################################

  def friend_request_params
    params.require(:friend_request).permit(:approved, :requestor_id, :requestee_id)
  end

end

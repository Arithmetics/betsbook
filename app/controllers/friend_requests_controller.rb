class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def show
    @friend_request = FriendRequest.find(params[:id])
  end


  def create

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

  def friend_requests_params
  end

end

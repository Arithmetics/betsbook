class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:update, :destroy]

  def show
    @friend_request = FriendRequest.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
  end


  def create
    @friend_request = current_user.sent_friend_requests.build(friend_request_params)
    @friend_request.update_attribute(:accepted, false)
    if @friend_request.save
      flash[:notice] = "Friend Request Sent"
      redirect_to request.referrer
    else
      flash[:notice] = "There was an error when creating the friend request"
    end
  end


  def update
    if @friend_request.accept
      flash[:notice] = "New Friendship Created!"
      redirect_to @friend_request.requestor
    else
      flash[:notice] = "something went wrong, your friendship was not created"
      redirect_to root_path
    end
  end


  def destroy
    @friend_request.destroy
    flash[:notice] = "Friendship DESTROYED!"
    redirect_to request.referrer
  end


  private ####################################################

  def friend_request_params
    params.require(:friend_request).permit(:approved, :requestor_id, :requestee_id)
  end

  def correct_user
    @friend_request = current_user.recieved_friend_requests.find(params[:id])
    redirect_to root_url if @friend_request.nil?
  end

end

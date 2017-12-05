class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy



  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:notice] = "you liked #{@like.post.user.username}'s post"
      redirect_to request.referrer
    else
      flash.now[:notice] = "you didnt end up liking the post"
    end
  end


  def destroy
    @user = @like.post.user
    @like.destroy
    flash[:notice] = "post unliked!"
    redirect_to @user
  end

  private ###################

    def like_params
      params.require(:like).permit(:post_id)
    end

    def correct_user
      @like = current_user.likes.find(params[:id])
      redirect_to root_url if @like.nil?
    end

end

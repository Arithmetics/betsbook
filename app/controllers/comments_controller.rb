class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "you comment was added on #{@comment.post.user.username}'s post"
      redirect_to @comment.post.user
    else
      flash.now[:notice] = "you didnt end up commenting on the post"
    end
  end

  def destroy
    @user = @comment.post.user
    @comment.destroy
    flash[:notice] = "comment "
    redirect_to @user
  end


  private ###################

    def comment_params
      params.require(:comment).permit(:post_id, :content)
    end

    def correct_user
      @comment = current_user.comments.find(params[:id])
      redirect_to root_url if @comment.nil?
    end

end

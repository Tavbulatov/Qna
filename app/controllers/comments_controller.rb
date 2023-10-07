class CommentsController < ApplicationController
  include VotableCommentable
  authorize_resource

  def create
    comment = set_resource(:commentable).comments.create(params_comment)
    if comment.persisted?
      flash[:notice] = 'You have added a comment'
    end

    render_json(comment, flash[:notice])

    ActionCable.server.broadcast("comments", comment.to_json)
  end

  def destroy
    comment = Comment.find(params[:id])

    if can? :destroy, comment
      comment.destroy
      flash[:notice] = 'Your comment has been successfully deleted'
      render_json(flash[:notice])
    end
  end

  private

  def params_comment
    params.require(:comment).permit(:comment).merge(author: current_user)
  end
end

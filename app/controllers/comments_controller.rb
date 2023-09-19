class CommentsController < ApplicationController
  include VotableCommentable

  def create
    comment = set_resource(:commentable).comments.create(params_comment)
    if comment.persisted?
      flash[:notice] = 'You have added a comment'
    end

    render_json(comment, flash[:notice])

    ActionCable.server.broadcast("comments", comment.to_json)
  end

  def destroy
    comment = Comment.find(params[:id]).destroy
    flash[:notice] = 'Your comment has been successfully deleted'
    render_json(flash[:notice])
  end

  private

  def params_comment
    params.require(:comment).permit(:body).merge(author: current_user)
  end
end

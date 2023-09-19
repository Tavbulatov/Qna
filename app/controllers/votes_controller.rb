class VotesController < ApplicationController
  include VotableCommentable

  def create
    #в методе set_resource уставналивается переменная @resource
    set_resource(:votable).votes.create(params_vote)
    flash[:notice] = 'Your vote has been counted'

    render_json(@resource.rating, flash[:notice], @resource.vote_author(current_user).id)
  end

  def destroy
    vote = Vote.find(params[:id]).destroy
    flash[:notice] = 'You deleted your vote'

    render_json(vote.votable.rating, flash[:notice])
  end

  private

  def params_vote
    params.require(:vote).permit(:body).merge(author: current_user)
  end
end

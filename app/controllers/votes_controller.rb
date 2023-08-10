class VotesController < ApplicationController
  def create
    set_votable.votes.create(params_vote)
    flash[:notice] = 'Your vote has been counted'

    render_json(set_votable, vote_id: set_votable.vote_author(current_user).id)
  end

  def destroy
    vote = Vote.find(params[:id]).destroy
    flash[:notice] = 'You deleted your vote'

    render_json(vote.votable)
  end

  private

  def render_json(model, options = {})
    respond_to do |format|
      format.json { render json: [model.rating, flash[:notice], options[:vote_id] ] }
    end
  end

  def set_votable
    @votable = params[:votable].constantize.find(model_id)
  end

  def model_id
    resource_id = "#{params[:votable]}_id"
    params[resource_id.underscore.to_sym]
  end

  def params_vote
    params.require(:vote).permit(:body).merge(author: current_user)
  end
end
